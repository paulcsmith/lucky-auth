module Authentic::SignInFormHelpers
  macro included
    def self.submit(params)
      new(params).submit do |form, user|
        yield form, user
      end
    end
  end

  def submit
    prepare
    if valid?
      yield self, user_from_email
    else
      yield self, nil
    end
  end

  private def password_matches?(user : User) : Bool
    Crypto::Bcrypt::Password.new(user.encrypted_password) == password.value.to_s
  end

  private def user_from_email : User?
    email.value.try do |value|
      UserQuery.new.email(value).first?
    end
  end
end
