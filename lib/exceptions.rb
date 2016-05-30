module Exceptions
  module Authentication
    class Required < StandardError; end
    class OnlyForGuests < StandardError; end
  end
end
