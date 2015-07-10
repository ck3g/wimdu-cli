module Wimdu
  module OptionHandler
    class Show < Base
      TITLE_JUST = 25

      def initialize(slug)
        @slug = slug
      end

      def run
        property = Property.find_by(slug: slug)
        if property
          puts "Displaying property details."
          puts
          property.manageable_fields.each do |field|
            title = FieldPresenter.new(field).title
            puts "#{title.rjust(TITLE_JUST)}: #{property.public_send(field)}"
          end
          puts
        else
          puts "No offers found."
        end

        true
      end

      private

      attr_reader :slug
    end
  end
end
