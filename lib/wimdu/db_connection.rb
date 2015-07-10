module Wimdu
  class DbConnection
    def self.init!(prefix = '')
      dir = File.expand_path(File.dirname(__FILE__))
      DataMapper.setup(:default, "sqlite://#{dir}/../../#{prefix}wimdu.db")
      DataMapper.auto_upgrade!
    end
  end
end
