module Shared::Layout
  macro included
    include Lucky::HTMLPage
    include Shared::FieldErrors
    include Shared::FlashMessages
    include Shared::Field

    needs signed_in? : Bool
  end

  abstract def content

  def shared_layout_head
    head do
      utf8_charset
      title page_title
      css_link asset("css/app.css")
      js_link asset("js/app.js")
      csrf_meta_tags
      responsive_meta_tag
    end
  end

  def page_title
    "Welcome to Lucky"
  end
end
