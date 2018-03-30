class SignIns::Create < BrowserAction
  include SkipRequireSignIn

  action do
    SignInForm.submit(params) do |form, signed_in_user|
      if signed_in_user
        session["user_id"] = signed_in_user.id.to_s
        flash.success = "Sign in worked!"
        redirect to: Users::Index
      else
        flash.danger = "Sign in failed"
        render NewPage, form: form
      end
    end
  end
end
