module Authentic
  Habitat.create do
    # Adjustable encryption cost.
    # Typically set to a lower value in test so tests run faster
    setting encryption_cost : Int32 = 10
    setting default_password_reset_expiration : Time::Span = 15.minutes
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

  # Send a password reset email to the user
  def self.request_password_reset(user : User)
    # generate password reset token
    # send password reset email
    RequestPasswordResetEmail.new(
      user,
      generate_password_reset_token(user)
    ).deliver
  end

  # Generates a password reset token
  def self.generate_password_reset_token(user : User, expires_after : Time::Span = Authentic.settings.default_password_reset_expiration) : String
    encryptor = Lucky::MessageEncryptor.new(secret: Lucky::Server.settings.secret_key_base)
    encryptor.encrypt_and_sign("#{user.id}:#{expires_after.from_now.to_utc.epoch_ms}")
  end

  def self.correct_password_reset_token?(user : User, token : String) : Bool
    encryptor = Lucky::MessageEncryptor.new(secret: Lucky::Server.settings.secret_key_base)
    user_id, expiration_in_ms = encryptor.verify_and_decrypt(token).to_s.split(":")
    expiration_in_ms.to_i <= Time.utc_now.epoch_ms && user_id == user.id
  end
end
