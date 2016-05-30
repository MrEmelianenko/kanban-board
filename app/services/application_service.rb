class ApplicationService
  # Getter
  attr_reader :errors

  def initialize
    @errors = {}
  end

  def self.run!(*args, &block)
    service = new(*args, &block)
    service.run
    service
  end

  def run
    raise NotImplemented, "Method `run` not implemented for service #{self.class}"
  end

  def success?
    errors.blank?
  end

  private

  # Setter
  attr_writer :errors

  def add_error(key, error)
    errors[key] ||= []
    errors[key] << error
  end

  def merge_model_errors(object)
    object.errors.each do |key, error|
      add_error(key, error)
    end
  end
end
