module ApplicationHelper
  def get_field_index(model, field)
    return model.column_names.index(field)
  end

  def null_or_not(field)
    if field == nil
      return "NULL"
    else
      return field
    end
  end
end
