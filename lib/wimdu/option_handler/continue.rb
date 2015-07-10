module Wimdu
  module OptionHandler
    class Continue < Base
      def initialize(slug)
        @slug = slug
      end

      def run
        property = Property.first(slug: slug)
        if property
          puts "Continuing with property #{slug}."
          puts
          %i(address).each do |field_name|
            handle_field_input field_name, property
          end
        else
          puts "Invalid property."
        end

        true
      end

      private

      attr_reader :slug
    end
  end
end
