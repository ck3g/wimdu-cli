module Wimdu
  module OptionHandler
    class New < Base
      def run
        property = Property.create_uniq
        puts "Starting with new property #{property.slug}."
        puts
        fields.each do |field_name, _|
          handle_field_input field_name, property
        end

        true
      end

      private

      def fields
        %i(title address)
      end
    end
  end
end
