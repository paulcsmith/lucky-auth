require "crypto/bcrypt/password"

class SignUpForm < User::BaseForm
  allow email
  allow_virtual password : String
  allow_virtual password_confirmation : String

  def prepare
    # TODO: add validate_uniqueness email
    validate_required password, password_confirmation
    validate_confirmation_of password, with: password_confirmation
    validate_size_of password, min: 6
    Authentic::SignUpFormHelpers.save_encrypted password, to: encrypted_password
  end
end
