require "crypto/bcrypt/password"

module Authentic::SignInFormHelpers
  macro included
    def self.submit(params)
      new(params).submit do |form, user|
        yield form, user
      end
    end
  end

  def submit
    on_submit(user_from_email)
    if valid?
      yield self, user_from_email
    else
      yield self, nil
    end
  end

  abstract def on_submit(user : User?)

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

  private def user_from_email : User?
    email.value.try do |value|
      UserQuery.new.email(value).first?
    end
  end
end
