class Home::Index < BrowserAction
  get "/" do
    redirect to: Users::Index
  end
end
