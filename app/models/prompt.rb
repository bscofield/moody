class Prompt < ActiveRecord::Base
  SEND_CHANCE = 20

  def self.send
    if rand(SEND_CHANCE) == 1 && Prompt.where(responded_at: nil).any?
      Prompting.email.deliver
    end
  end
end
