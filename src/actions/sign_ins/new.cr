class SignIns::New < BrowserAction
  include RedirectIfSignedIn

  action do
    render NewPage, form: SignInForm.new
  end
end
