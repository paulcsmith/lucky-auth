class PasswordResets::New < BrowserAction
  include Auth::PasswordResets::Base

  param token : String

  get "/password_resets/:user_id" do
    make_token_available_to_future_actions
    redirect to: PasswordResets::Edit.with(user_id)
  end

  private def make_token_available_to_future_actions
    session[:password_reset_token] = token
  end
end
