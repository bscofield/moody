class Mood < ActiveRecord::Base
  POSITIVE_WORDS = File.readlines(Rails.root.join('db', 'positive_words.txt')).map(&:strip)
  NEGATIVE_WORDS = File.readlines(Rails.root.join('db', 'negative_words.txt')).map(&:strip)

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

    if prompt = Prompt.outstanding
      prompt.update_attribute :responded_at, Time.now
    end

    Mood.create({
      recorded_at: Time.now,
      emotion: emotion,
      notes: notes,
      score: classify(emotion)
    })
  end

  def self.classify(emotion)
    if POSITIVE_WORDS.include?(emotion.upcase)
      1
    elsif NEGATIVE_WORDS.include?(emotion.upcase)
      -1
    else
      0
    end
  end
end
