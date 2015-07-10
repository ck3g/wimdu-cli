module Wimdu
  module OptionHandler
    class Base
      def initialize(*args)
        @args = args
      end

      protected

      def handle_field_input(field_name, property)
        puts "#{field_name.to_s.capitalize}: "
        data = STDIN.gets.chomp
        property.update field_name => data
      end
    end
  end
end
