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
      puts "#{Wimdu::FieldPresenter.new(field_name).title}: "
      data = STDIN.gets.chomp
      property.public_send(:"#{field_name}=", data)

      return if property.update_attributes field_name => data

      display_validation_error field_name
      handle_field_input field_name
    end

    def display_success_message
      return unless missing_fields.empty?
      puts "Great job! Listing #{property.slug} is complete!"
      property.publish!
    end

    def display_validation_error(field_name)
      puts
      puts "Error: #{property.errors.messages[field_name].join(', ')}"
      puts
    end
  end
end
