class User < BaseModel
  table :users do
    column email : String
    column encrypted_password : String
  end
end
