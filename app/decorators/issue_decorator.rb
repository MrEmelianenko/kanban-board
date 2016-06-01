class IssueDecorator < ApplicationDecorator
  delegate_all

  def priority_colored
    case object.priority.to_sym
    when :low
      span_class = 'text-success'
    when :medium
      span_class = 'text-warning'
    when :high
      span_class = 'text-danger'
    else
      span_class = ''
    end

    h.content_tag :span, object.priority.capitalize, class: span_class
  end

  def type
    object.issue_type.name
  end

  def creator_name(options = {})
    options.reverse_merge!(link: false)

    name = object.creator.name

    if options[:link]
      h.link_to name, h.user_url(object.creator)
    else
      name
    end
  end

  def assigned_to_name(options = {})
    options.reverse_merge!(link: false)
    return 'Not assigned, yet' if object.assigned_to_id.blank?

    name = object.assigned_to.name

    if options[:link]
      h.link_to name, h.user_url(object.assigned_to)
    else
      name
    end
  end

  def estimate_readable
    if object.estimate.blank?
      'Not estimated, yet'
    else
      h.pluralize(object.estimate, 'minute')
    end
  end
end
