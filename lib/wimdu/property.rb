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
      slug = generate_uniq_slug
      slug = generate_uniq_slug while first(slug: slug)
      slug
    end

    def self.generate_uniq_slug
      SecureRandom.hex(4).upcase
    end
  end
end
