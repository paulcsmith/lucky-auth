module Authentic::ActionHelpers
  private def sign_in(user : User)
    session["user_id"] = user.id.to_s
  end

  private def sign_out
    session.destroy
  end

  private def signed_in? : Bool
    !!current_user?
  end

  private def current_user : User
    current_user?.not_nil!
  end

  private def current_user? : User?
    user_id = session["user_id"]
    if user_id
      UserQuery.new.id(user_id).first?
    end
  end
end
