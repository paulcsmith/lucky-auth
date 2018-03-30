class Users::IndexPage < MainLayout
  needs users : UserQuery

  def content
    h1 "Users"
    ul do
      @users.each do |user|
        li user.email
      end
    end
  end
end
