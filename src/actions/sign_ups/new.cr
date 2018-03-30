class SignUps::New < BrowserAction
  include RedirectIfSignedIn

  get "/sign_up" do
    render NewPage, form: SignUpForm.new
  end
end
