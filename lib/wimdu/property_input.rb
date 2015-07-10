module Wimdu
  class PropertyInput
    def initialize(property)
      @property = property
    end

    def perform
      property.missing_fields.each do |field_name|
        handle_field_input field_name, property
      end
    end

    protected

    attr_reader :property

    def handle_field_input(field_name, property)
      puts "#{field_name.to_s.capitalize}: "
      data = STDIN.gets.chomp
      property.update field_name => data
    end
  end
end
