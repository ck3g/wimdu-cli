module Wimdu
  module OptionHandler
    class New < Base
      def run
        property = Property.create_uniq
        puts "Starting with new property #{property.slug}."
        puts
        property.missing_fields.each do |field_name|
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
