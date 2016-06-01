class ApplicationDecorator < Drape::Decorator
  def format_date(field)
    object.public_send(field).to_s(:short)
  end
end
