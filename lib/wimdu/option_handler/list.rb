module Wimdu
  module OptionHandler
    class List < Base
      def run
        properties = Wimdu::Property.all
        if properties.any?
          puts "Found #{properties.count} offer."
          puts
          properties.each do |property|
            puts "#{property.slug}: #{property.title}"
          end
        else
          puts "No offers found."
        end
      end
    end
  end
end
