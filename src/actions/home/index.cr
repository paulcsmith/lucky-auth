class Home::Index < BrowserAction
  get "/" do
    redirect to: SignUps::New
  end
end
