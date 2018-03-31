module Authentic
  Habitat.create do
    # Adjustable encryption cost.
    # Typically set to a lower value in test so tests run faster
    setting encryption_cost : Int32 = 10
  end

  # Run the given block when the password field is incorrect
  def self.when_password_is_wrong(
    user : User,
    password_field : LuckyRecord::Field | LuckyRecord::AllowedField
  )
    unless correct_password?(user, password_field.value.to_s)
      yield
    end
  end

  # Checks whether the password is correct
  def self.correct_password?(
    user : User,
    password_value : String
  ) : Bool
    Crypto::Bcrypt::Password.new(user.encrypted_password) == password_value
  end

  # Encrypts and sets the password
  def self.save_encrypted(
    password_field : LuckyRecord::Field | LuckyRecord::AllowedField,
    to encrypted_password_field : LuckyRecord::Field | LuckyRecord::AllowedField
  )
    password_field.value.try do |value|
      encrypted_password_field.value = create_hashed_password(value).to_s
    end
  end

  # Creates a hashed/encrypted password from a password string
  def self.create_hashed_password(password_value : String) : String
    Crypto::Bcrypt::Password.create(
      password_value,
      cost: settings.encryption_cost
    ).to_s
  end
end
