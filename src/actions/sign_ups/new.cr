class SignUps::New < BrowserAction
  include RedirectIfSignedIn

  action do
    render NewPage, form: SignUpForm.new
  end
end
