module Wimdu
  class FieldPresenter
    def initialize(field_name)
      @field_name = field_name
    end

    def title
      available_titles.fetch(field_name) { field_name.to_s.capitalize }
    end

    private

    attr_reader :field_name

    def available_titles
      {
        title: 'Title',
        address: 'Address',
        property_type: 'Property type',
        nightly_rate: 'Nightly rate in EUR',
        guests: 'Max guests',
        email: 'Email',
        phone: 'Phone number'
      }
    end
  end
end
