require "./authentic/sign_in_form_helpers"

class SignInForm < LuckyRecord::VirtualForm
  include Authentic::SignInFormHelpers

  allow_virtual email : String
  allow_virtual password : String

  private def on_submit(user : User?)
    if user
      Authentic::SignInFormHelpers.on_incorrect_password(user, password) do
        password.add_error "is incorrect"
      end
    else
      email.add_error "is not in our system"
    end
  end
end
