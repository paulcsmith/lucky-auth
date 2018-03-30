require "./authentic/sign_in_form_helpers"

class SignInForm < LuckyRecord::VirtualForm
  include Authentic::SignInFormHelpers

  allow_virtual email : String
  allow_virtual password : String

  private def validate_allowed_to_sign_in(user : User)
    Authentic.on_incorrect_password(user, password) do
      password.add_error "is incorrect"
    end
    # You can add additional checks in this method
    #
    #    if user.locked?
    #      email.add_error "is locked out"
    #    end
  end

  private def validate_allowed_to_sign_in(user_not_found : Nil)
    email.add_error "is not in our system"
  end
end
