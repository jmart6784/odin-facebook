ActionMailer::Base.smtp_settings = {
  domain: 'odinbook-app.herokuapp.com.herokuapp.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      ENV["SENDGRID_USERNAME"],
  password:       ENV["SENDGRID_PASSWORD"]
}