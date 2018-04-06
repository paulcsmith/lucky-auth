module Auth::PasswordResets::RequireToken
  macro included
    before require_valid_password_reset_token
  end

  abstract def token : String
  abstract def user : User

  private def require_valid_password_reset_token
    if Authentic.correct_password_reset_token?(user, token)
      make_token_available_to_future_actions
      flash.danger = "The password reset link is incorrect or expired. Please try again."
      redirect to: PasswordResetRequests::New
    else
      continue
    end
  end

  private def make_token_available_to_future_actions
    session[:password_reset_token] = token
  end
end
