class Prompt < ActiveRecord::Base
  SEND_CHANCE = ENV['SEND_CHANCE'] || 4

  def self.outstanding
    Prompt.where(responded_at: nil).first
  end

  def self.deliver
    if rand(SEND_CHANCE) == 1 && !Prompt.outstanding
      Prompt.create(requested_at: Time.now)
      Prompting.email.deliver
    end
  end
end
