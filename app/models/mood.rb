class Mood < ActiveRecord::Base
  def self.record(raw)
    if prompt = Prompt.outstanding
      prompt.update_attribute :responded_at, Time.now
    end

    Rails.logger.info raw.inspect
  end
end
