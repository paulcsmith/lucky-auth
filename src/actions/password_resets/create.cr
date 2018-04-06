class PasswordResets::Create < BrowserAction
  include Auth::RedirectIfSignedIn
  include Auth::PasswordResets::FindUser
  include Auth::PasswordResets::RequireToken

  post "/password_resets/:user_id" do
    PasswordResetForm.update(user, params) do |form, user|
      if form.saved?
        session.delete(:password_reset_token)
        flash.success = "Your password has been reset"
        redirect to: Home::Index
      else
        render NewPage, form: form, user_id: user_id.to_i
      end
    end
  end

  private def token : String
    session[:password_reset_token] || raise "Password reset token not found in session"
  end
end
