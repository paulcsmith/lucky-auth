module RedirectIfSignedIn
  macro included
    include SkipRequireSignIn
    before redirect_if_signed_in
  end

  private def redirect_if_signed_in
    if signed_in?
      redirect to: Home::Index
    else
      continue
    end
  end
end
