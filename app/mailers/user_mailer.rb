class UserMailer < ApplicationMailer
  def confirm_email(user)
    @user = user
    mail( to: @user.email, subject: "Please Confirm Your Email Address" )
  end

  def account_activated(user)
    @user = user
    mail( to: @user.email, subject: "Your Account has been Activated" )
  end
end
