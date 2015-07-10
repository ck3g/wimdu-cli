module Wimdu
  module OptionHandler
    class New < Base
      def run
        property = Property.create_uniq
        puts "Starting with new property #{property.slug}."
        puts
        puts "Title: "
        title = STDIN.gets.chomp
        property.update title: title
        puts "Address: "
        address = STDIN.gets
        property.update address: address

        true
      end
    end
  end
end
