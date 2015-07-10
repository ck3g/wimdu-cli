module Wimdu
  class Property < ActiveRecord::Base
    PROPERTY_TYPES = ['holiday home', 'apartment', 'private room']

    validates :guests, numericality: {
      only_integer: true, message: 'must be a number'
    }, allow_blank: true

    validates :nightly_rate, numericality: {
      only_integer: true, message: 'must be a number'
    }, allow_blank: true

    validates :property_type, inclusion: {
      in: PROPERTY_TYPES,
      message: "must be one of: #{PROPERTY_TYPES.join(', ')}"
    }, allow_blank: true

    scope :published, -> { where status: 'published' }
    scope :draft, -> { where status: 'draft' }

    def self.create_uniq
      create slug: uniq_slug
    end

    def missing_fields
      manageable_fields.select { |field| public_send(field).blank? }
    end

    def publish!
      update status: 'published'
    end

    private

    def self.uniq_slug
      slug = SlugGenerator.generate
      slug = SlugGenerator.generate while find_by(slug: slug)
      slug
    end

    def manageable_fields
      %i(title address guests property_type nightly_rate email phone)
    end
  end
end
