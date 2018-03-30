module Auth::RedirectIfSignedIn
  macro included
    include Auth::SkipRequireSignIn
    before redirect_if_signed_in
    unexpose current_user
  end

  private def redirect_if_signed_in
    if signed_in?
      redirect to: Home::Index
    else
      continue
    end
  end

  # current_user should always be nil since the action will redirect if
  # the user is signed in
  def current_user
  end
end
