module Wimdu
  class SlugGenerator
    def self.generate
      SecureRandom.hex(4).upcase
    end
  end
end
