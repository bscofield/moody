class Prompting < ActionMailer::Base
  default from: "moody@example.com"

  def email
    mail to: ENV['RECIPIENT']
  end
end
