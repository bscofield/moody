class Mood < ActiveRecord::Base
  def self.record(raw)
    if prompt = Prompt.outstanding
      prompt.update_attribute :responded_at, Time.now
    end

    pieces = raw.split(/---------- Reply above this line ----------/)
    notes = pieces.first.split(/[\r\n]+/).map(&:strip)

    Mood.create({
      recorded_at: Time.now,
      emotion: notes[0],
      notes: notes[1]
    })
  end
end
