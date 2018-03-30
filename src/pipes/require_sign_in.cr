module RequireSignIn
  macro included
    before require_sign_in
  end

  private def require_sign_in
    if signed_in?
      continue
    else
      flash.info = "Please sign in first"
      redirect to: SignIns::New
    end
  end
end
