module ServiceErrorsHelper
  def render_full_errors(errors)
    render partial: 'shared/errors/full', locals: { errors: errors }
  end

  def render_base_errors(errors)
    render partial: 'shared/errors/base', locals: { errors: errors }
  end

  def render_field_error(errors, field)
    render partial: 'shared/errors/field', locals: { errors: errors, field: field }
  end
end
