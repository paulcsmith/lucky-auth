class SignIns::New < BrowserAction
  include SkipRequireSignIn

  action do
    text "Render something in SignIns::New"
  end
end
