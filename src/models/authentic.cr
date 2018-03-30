module Authentic
  Habitat.create do
    setting encryption_cost : Int32 = 10
  end

  def self.on_incorrect_password(
    user : User,
    password_field : LuckyRecord::Field | LuckyRecord::AllowedField
  )
    unless correct_password?(user, password_field)
      yield
    end
  end

  def self.correct_password?(
    user : User,
    password_field : LuckyRecord::Field | LuckyRecord::AllowedField
  ) : Bool
    Crypto::Bcrypt::Password.new(user.encrypted_password) == password_field.value.to_s
  end

  def self.save_encrypted(
    password_field : LuckyRecord::Field | LuckyRecord::AllowedField,
    to encrypted_password_field : LuckyRecord::Field | LuckyRecord::AllowedField
  )
    password_field.value.try do |value|
      encrypted_password_field.value = create_hashed_password(value).to_s
    end
  end

  def self.create_hashed_password(password_value : String) : String
    Crypto::Bcrypt::Password.create(
      password_value,
      cost: settings.encryption_cost
    ).to_s
  end
end
