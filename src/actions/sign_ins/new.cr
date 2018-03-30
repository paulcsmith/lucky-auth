class SignIns::New < BrowserAction
  include RedirectIfSignedIn

  get "/sign_in" do
    render NewPage, form: SignInForm.new
  end
end
