module Wimdu
  module OptionHandler
    class List < Base
      def run
        properties = Wimdu::Property.published
        if properties.any?
          cnt = properties.count
          puts "Found #{cnt} #{"offer".pluralize(cnt)}."
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
