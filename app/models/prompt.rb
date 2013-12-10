class Prompt < ActiveRecord::Base
  SEND_CHANCE = 20

  def self.outstanding
    Prompt.where(responded_at: nil).first
  end

  def self.deliver
    if rand(SEND_CHANCE) == 1 && Prompt.outstanding
      Prompting.email.deliver
    end
  end
end
