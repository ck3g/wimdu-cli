module Wimdu
  class DbConnection
    def self.init!(prefix = '')
      dir = File.expand_path(File.dirname(__FILE__))

      ActiveRecord::Base.establish_connection(
        adapter:  "sqlite3",
        database: "#{dir}/../../#{prefix}wimdu.db"
      )

      ActiveRecord::Schema.define do
        unless ActiveRecord::Base.connection.tables.include? 'properties'
          create_table :properties do |t|
            t.column :slug, :string
            t.column :title, :string
            t.column :address, :string
            t.column :guests, :integer
            t.column :status, :string, default: 'draft'
          end
        end
      end
    end
  end
end
