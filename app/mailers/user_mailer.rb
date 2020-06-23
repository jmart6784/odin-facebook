class UserMailer < ApplicationMailer
  default from: 'odinbook3000@gmail.com'

  def welcome_email(email)
    @user = email
    @url = "http://localhost:3000/"
    mail(to: @user.email, subject: "Welcome to Odin Book")
  end
end