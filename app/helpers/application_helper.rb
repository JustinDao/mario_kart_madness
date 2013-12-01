module ApplicationHelper
    def get_field_index(model, field)
    return model.column_names.index(field)
  end
end
