abstract class GuestLayout
  include Lucky::HTMLPage
  include Shared::FieldErrorsComponent
  include Shared::FlashComponent

  abstract def content

  def render
    html_doctype

    html lang: "en" do
      head do
        utf8_charset
        title page_title
        css_link asset("css/app.css")
        js_link asset("js/app.js")
        csrf_meta_tags
        responsive_meta_tag
      end

      body do
        render_flash
        content
      end
    end
  end

  def page_title
    "Welcome to Lucky"
  end
end
