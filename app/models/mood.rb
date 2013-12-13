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
end
