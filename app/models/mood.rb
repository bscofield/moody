class Mood < ActiveRecord::Base
  belongs_to :emotion

  delegate :word, :score, to: :emotion

  def self.create(*args)
    super

    if prompt = Prompt.outstanding
      prompt.update_attribute :responded_at, Time.now
    end
  end

  def self.record(params)
    if raw = params.delete('body-plain')
      pieces = raw.split(/---------- Reply above this line ----------/)
      parts = pieces.first.split(/[\r\n]+/).map(&:strip)
      emotion = parts[0]
      notes = parts[1]
    else
      emotion = params['emotion']
      notes = params['notes']
    end

    emotion = Emotion.where(word: emotion.upcase).first || Emotion.create(word: emotion.upcase, score: 0)

    Mood.create({
      emotion: emotion,
      recorded_at: Time.now,
      notes: notes
    })
  end

  def self.summarize(starting, ending)
    starting = starting.beginning_of_day
    ending   = ending.beginning_of_day

    moods = Mood.where(['recorded_at >= ? AND recorded_at < ?', starting, ending]).load
    by_day = moods.group_by {|mood| mood.recorded_at.strftime('%Y-%m-%d')}

    avg, stdev = stats(moods)

    buffer = {
      week: {
        average: avg,
        stdev: stdev
      }, days: {}
    }

    by_day.each do |day, day_moods|
      avg, stdev = stats(day_moods)
      buffer[:days][day] = {
        average: avg,
        stdev: stdev
      }
    end

    buffer
  end

  def self.stats(moods)
    sum = moods.map(&:score).sum
    mean = sum / moods.length.to_f
    var_sum = moods.inject(0) {|accum, i| accum + (i.score-mean)**2 }
    svar = var_sum / (moods.length - 1).to_f

    return mean, Math.sqrt(svar)
  end
end
