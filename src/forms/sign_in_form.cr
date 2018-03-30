require "crypto/bcrypt/password"

class SignInForm < LuckyRecord::VirtualForm
  allow_virtual email : String
  allow_virtual password : String

  def self.submit(params)
    new(params).submit do |form, user|
      yield form, user
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

  private def prepare
    validate_email_found
    validate_email_and_password_match
  end

  private def validate_email_found
    if user_from_email.nil?
      email.add_error "is not in our system"
    end
  end

  private def validate_email_and_password_match
    user_from_email.try do |user|
      unless password_matches?(user)
        password.add_error "is incorrect"
      end
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
