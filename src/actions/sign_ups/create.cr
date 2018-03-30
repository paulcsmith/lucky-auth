class SignUps::Create < BrowserAction
  action do
    SignUpForm.create(params) do |form, user|
      if user
        flash.info = "Signed up!"
        redirect to: SignUps::New
      else
        flash.info = "Couldn't sign you up"
        render NewPage, form: form
      end
    end
  end
end
