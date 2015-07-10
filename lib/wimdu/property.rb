module Wimdu
  class Property < ActiveRecord::Base

    def self.create_uniq
      create slug: uniq_slug
    end

    def self.published
      where status: 'published'
    end

    def self.draft
      where status: 'draft'
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
      %i(title address)
    end
  end
end
