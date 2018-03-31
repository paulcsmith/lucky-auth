require "./authentic/base_request_password_reset_form"

class RequestPasswordResetForm < LuckyRecord::VirtualForm
  include Authentic::BaseRequestPasswordResetForm

  allow_virtual email : String

  def prepare
    validate_required email
  end

  def when_valid(user : User)
    Authentic.request_password_reset(user)
  end
end
