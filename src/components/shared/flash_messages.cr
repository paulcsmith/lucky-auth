module Shared::FlashMessages
  def render_flash
    @context.flash.each do |flash_type, flash_message|
      div class: "flash-#{flash_type}" do
        text flash_message
      end
    end
  end
end
