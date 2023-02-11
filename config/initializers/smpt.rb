ActionMailer::Base.smtp_settings = {
  domain: 'odinbook.fly.dev',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      Rails.application.credentials.dig(:sendgrid, :username),
  password:       Rails.application.credentials.dig(:sendgrid, :password)
}