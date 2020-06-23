# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name =>  ENV['SENDGRID_USERNAME'],
  :api_key => ENV['SENDGRID_API_KEY'],
  :domain => ENV['SENDGRID_DOMAIN'],
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}