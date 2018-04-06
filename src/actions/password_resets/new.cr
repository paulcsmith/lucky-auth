class PasswordResets::New < BrowserAction
  include Auth::RedirectIfSignedIn
  include Auth::PasswordResets::FindUser
  include Auth::PasswordResets::RequireToken

  param token : String

  get "/password_resets/:user_id" do
    render NewPage, form: PasswordResetForm.new, user_id: user_id.to_i
  end
end
