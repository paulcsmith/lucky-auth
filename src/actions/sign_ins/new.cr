class SignIns::New < BrowserAction
  include SkipRequireSignIn

  action do
    render NewPage, form: SignInForm.new
  end
end
