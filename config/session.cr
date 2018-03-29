require "./server"

Lucky::Session::Store.configure do
  settings.key = "lucky_auth"
  settings.secret = Lucky::Server.settings.secret_key_base
end
