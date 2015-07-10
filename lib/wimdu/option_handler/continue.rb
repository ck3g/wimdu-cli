module Wimdu
  module OptionHandler
    class Continue < Base
      def initialize(property_id)
        @property_id = property_id
      end

      def run
        puts "Continuing with property #{property_id}."
        puts
        puts "Address: "
        address = STDIN.gets

        true
      end

      private

      attr_reader :property_id
    end
  end
end
