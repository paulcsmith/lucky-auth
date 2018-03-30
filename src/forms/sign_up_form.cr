require "crypto/bcrypt/password"

class SignUpForm < User::BaseForm
  allow email
  allow_virtual password : String
  allow_virtual password_confirmation : String

  def prepare
    validate_required password, password_confirmation
    validate_confirmation_of password, with: password_confirmation
    validate_size_of password, min: 6
    save_encrypted password, to: encrypted_password
  end

  private def save_encrypted(password_field, to encrypted_password_field)
    password_field.value.try do |value|
      hashed_password = Crypto::Bcrypt::Password.create(value, cost: 10).to_s
      encrypted_password_field.value = hashed_password
    end
  end
end
