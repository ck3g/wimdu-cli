module Wimdu
  module OptionHandler
    class New < Base
      def run
        property = Property.create_uniq
        puts "Starting with new property #{property.slug}."
        puts
        PropertyInput.new(property).perform

        true
      end
    end
  end
end
