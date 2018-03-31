require "crypto/bcrypt/password"

module Authentic::BaseRequestPasswordResetForm
  macro included
    def self.submit(params)
      new(params).submit do |form|
        yield form
      end
    end
  end

  def submit
    prepare
    valid? && user_from_email.try do |user|
      when_valid(user)
    end
    yield self
  end

  abstract def prepare

  private def user_from_email : User?
    email.value.try do |value|
      UserQuery.new.email(value).first?
    end
  end
end
