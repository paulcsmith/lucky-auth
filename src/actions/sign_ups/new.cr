class SignUps::New < BrowserAction
  include SkipRequireSignIn

  action do
    render NewPage, form: SignUpForm.new
  end
end
