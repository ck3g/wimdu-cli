module Wimdu
  class PropertyInput
    def initialize(property)
      @property = property
    end

    def perform
      missing_fields.each { |field_name| handle_field_input field_name }
      display_success_message
    end

    protected

    attr_reader :property

    def missing_fields
      property.missing_fields
    end

    def handle_field_input(field_name)
      puts "#{field_name.to_s.capitalize}: "
      data = STDIN.gets.chomp
      property.public_send(:"#{field_name}=", data)
      unless property.update_attributes field_name => data
        puts "Error: #{property.errors.messages[field_name].join(', ')}"
        handle_field_input field_name
      end
    end

    def display_success_message
      return unless missing_fields.empty?
      puts "Great job! Listing #{property.slug} is complete!"
      property.publish!
    end
  end
end
