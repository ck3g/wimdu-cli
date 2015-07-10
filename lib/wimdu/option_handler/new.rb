module Wimdu
  module OptionHandler
    class New < Base
      def run
        puts "Starting with new property ABC1DEF2."
        puts
        puts "Title: "
        title = STDIN.gets.chomp
        puts "Address: "
        address = STDIN.gets

        true
      end
    end
  end
end
