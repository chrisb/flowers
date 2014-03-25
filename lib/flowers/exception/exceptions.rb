module Flowers
  module Exception

    class Base < StandardError
    end

    class InvalidCategoryError < Base
    end

    class InvalidOperationError < Base
    end

  end
end
