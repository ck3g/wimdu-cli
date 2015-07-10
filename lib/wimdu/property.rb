module Wimdu
  class Property
    include DataMapper::Resource

    property :id, Serial
    property :slug, String
    property :title, String
    property :address, String
    property :status, String, default: 'draft'

    def self.create_uniq
      create slug: uniq_slug
    end

    def self.published
      all status: 'published'
    end

    def self.draft
      all status: 'draft'
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
      slug = SlugGenerator.generate while first(slug: slug)
      slug
    end

    def manageable_fields
      %i(title address)
    end
  end
end
