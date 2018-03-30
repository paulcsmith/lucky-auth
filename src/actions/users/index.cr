class Users::Index < BrowserAction
  action do
    render IndexPage, users: UserQuery.new
  end
end
