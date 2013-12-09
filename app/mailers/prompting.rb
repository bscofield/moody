class Prompting < ActionMailer::Base
  default from: ENV['MAILGUN_SMTP_LOGIN'].sub(/postmaster/, 'moody')

  def email
    mail to: ENV['RECIPIENT']
  end
end
