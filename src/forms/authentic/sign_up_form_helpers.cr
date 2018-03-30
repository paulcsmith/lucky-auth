require "crypto/bcrypt/password"

module Authentic::SignUpFormHelpers
  Habitat.create do
    setting encryption_cost : Int32 = 10
  end

  def self.save_encrypted(password_field, to encrypted_password_field)
    password_field.value.try do |value|
      encrypted_password_field.value = create_hashed_password(value).to_s
    end
  end

  private def self.create_hashed_password(password_value : String) : String
    Crypto::Bcrypt::Password.create(
      password_value,
      cost: settings.encryption_cost
    ).to_s
  end
end
