module Wimdu
  class CLI
    def run(args = ARGV)
      if args.first == 'list'
        puts "No offers found."
      elsif args.first == 'new'
        puts "Starting with new property ABC1DEF2."
        puts
        puts "Title: "
        title = STDIN.gets.chomp
        puts "Address: "
        address = STDIN.gets
      elsif args.first == "continue"
        puts "Continuing with property #{args[1]}."
        puts
        puts "Address: "
        address = STDIN.gets
      else
        puts "Invalid args."
      end
    end
  end
end
