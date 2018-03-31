class PasswordResets::NewPage < GuestLayout
  needs form : RequestPasswordResetForm

  def content
    h1 "Reset your password"
    render_form(@form)
  end

  private def render_form(f)
    form_for PasswordResets::Create do
      field(f.email) { |i| email_input i }
      submit "Reset Password"
    end
  end
end
