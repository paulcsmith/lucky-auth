class SignUpForm < User::BaseForm
  allow email
  allow_virtual password : String
  allow_virtual password_confirmation : String

  def prepare
    validate_uniqueness_of email, query: UserQuery.new.email, message: "is not available"
    validate_required password, password_confirmation
    validate_confirmation_of password, with: password_confirmation
    validate_size_of password, min: 6
    Authentic::SignUpFormHelpers.save_encrypted password, to: encrypted_password
  end

  private def validate_uniqueness_of(
    field : LuckyRecord::Field | LuckyRecord::AllowedField,
    query : LuckyRecord::Criteria? = nil,
    message : String = "is already taken"
  )
    field.value.try do |value|
      prepared_query = prepare_query(query, field.name, value)
      if prepared_query.first?
        field.add_error message
      end
    end
  end

  private def prepare_query(
    query : LuckyRecord::Criteria?,
    column_name,
    value
  ) : T::BaseQuery
    if query
      query.is(value)
    else
      T::BaseQuery.new.where(column_name, value)
    end
  end
end
