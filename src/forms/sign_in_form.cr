require "./authentic/sign_in_form_helpers"
require "crypto/bcrypt/password"

class SignInForm < LuckyRecord::VirtualForm
  include Authentic::SignInFormHelpers

  allow_virtual email : String
  allow_virtual password : String

  private def on_submit(user : User?)
    if user
      validate_email_and_password_match(user)
    else
      email.add_error "is not in our system"
    end
  end

  private def validate_email_and_password_match(user : User)
    unless Authentic::SignInFormHelpers.correct_password?(user, password)
      password.add_error "is incorrect"
    end
  end
end
