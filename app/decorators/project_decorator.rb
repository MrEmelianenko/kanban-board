class ProjectDecorator < Drape::Decorator
  delegate_all

  def formatted_created_at
    object.created_at.to_s(:short)
  end
end
