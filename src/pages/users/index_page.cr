class Users::IndexPage < MainLayout
  needs users : UserQuery

  def content
    h1 "Users"
    ul do
      @users.each do |user|
        li { link user.email, to: Users::Show.with(user.id) }
      end
    end
  end
end
