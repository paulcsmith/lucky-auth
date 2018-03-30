class SignIns::Create < BrowserAction
  include RedirectIfSignedIn

  action do
    SignInForm.submit(params) do |form, authenticated_user|
      if authenticated_user
        sign_in(authenticated_user)
        flash.success = "Sign in worked!"
        redirect to: Users::Index
      else
        flash.danger = "Sign in failed"
        render NewPage, form: form
      end
    end
  end
end
