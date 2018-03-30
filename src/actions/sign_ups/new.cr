class SignUps::New < BrowserAction
  action do
    render NewPage, form: SignUpForm.new
  end
end
