class UserMailer < ApplicationMailer
  default from: 'odinbook3000@gmail.com'

  def welcome_email(email)
    @user = email
    @url = "https://odinbook-app.herokuapp.com/"
    mail(to: @user.email, subject: "Welcome to Odin Book")
  end
end