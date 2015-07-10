module Wimdu
  class Property
    include DataMapper::Resource

    property :id, Serial
    property :slug, String
    property :title, String
  end
end
