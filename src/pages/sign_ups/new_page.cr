class SignUps::NewPage < GuestLayout
  needs form : SignUpForm

  def content
    h1 "Sign Up!"
    render_sign_up_form(@form)
  end

  private def render_sign_up_form(f)
    form_for SignUps::Create do
      label_for f.email
      email_input f.email
      errors_for f.email

      label_for f.password
      password_input f.password
      errors_for f.password

      label_for f.password_confirmation
      password_input f.password_confirmation
      errors_for f.password_confirmation

      submit "Sign Up"
    end
  end
end
