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
          PropertyInput.new(property).perform
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
