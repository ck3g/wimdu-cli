module Wimdu
  class Property
    include DataMapper::Resource

    property :id, Serial
    property :slug, String
    property :title, String
    property :address, String

    def self.create_uniq
      create slug: uniq_slug
    end

    private

    def self.uniq_slug
      slug = SlugGenerator.generate
      slug = SlugGenerator.generate while first(slug: slug)
      slug
    end
  end
end
