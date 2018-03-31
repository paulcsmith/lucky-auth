class PasswordResets::New < BrowserAction
  include Auth::RedirectIfSignedIn

  action do
    render NewPage, form: RequestPasswordResetForm.new
  end
end
