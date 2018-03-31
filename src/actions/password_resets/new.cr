class PasswordResets::New < BrowserAction
  param token : String

  get "/password_resets/:id" do
    user = UserQuery.find(id)
    Authentic.correct_password_reset_token?(user, token)
    text "Password reset"
  end
end
