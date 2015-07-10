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

      def handle_field_input(field_name, property)
        puts "#{fields[field_name]}: "
        data = STDIN.gets.chomp
        property.update field_name => data
      end

      def fields
        {
          title: 'Title',
          address: 'Address'
        }
      end
    end
  end
end
