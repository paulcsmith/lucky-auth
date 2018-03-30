abstract class MainLayout
  include Shared::Layout

  # You can put things here that all pages need
  #
  # Example:
  #   needs current_user : User
  needs current_user : User

  def render
    html_doctype

    html lang: "en" do
      shared_layout_head

      body do
        h1 "Signed in as: "
        text @current_user.email
        render_flash
        content
      end
    end
  end
end
