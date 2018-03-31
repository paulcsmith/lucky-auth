class SignUpForm < User::BaseForm
  allow email
  allow_virtual password : String
  allow_virtual password_confirmation : String

  def prepare
    validate_uniqueness_of email
    validate_required password, password_confirmation
    validate_confirmation_of password, with: password_confirmation
    validate_size_of password, min: 6
    Authentic.save_encrypted password, to: encrypted_password
  end
end
