module RequireSignIn
  macro included
    before require_sign_in
  end

  private def require_sign_in
    if signed_in?
      continue
    else
      flash.info = "Please sign in first"
      redirect to: SignIns::New
    end
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
