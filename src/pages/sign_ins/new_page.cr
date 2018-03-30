class SignIns::NewPage < GuestLayout
  needs form : SignInForm

  def content
    h1 "Sign In"
    render_sign_in_form(@form)
  end

  private def render_sign_in_form(f)
    form_for SignIns::Create do
      label_for f.email
      email_input f.email
      errors_for f.email

      label_for f.password
      password_input f.password
      errors_for f.password

      submit "Sign In"
    end
    link "Sign up instead", to: SignUps::New
  end
end
