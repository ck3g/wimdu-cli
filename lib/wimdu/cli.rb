module Wimdu
  class CLI
    def run(args = ARGV)
      Wimdu::DbConnection.init!

      options = {
        'list' => Wimdu::OptionHandler::List,
        'show' => Wimdu::OptionHandler::Show,
        'new' => Wimdu::OptionHandler::New,
        'continue' => Wimdu::OptionHandler::Continue,
        'help' => Wimdu::OptionHandler::Help
      }

      option_handler = options.fetch(args.first) { options.fetch('help') }
      option_handler.new(args[1]).run
    end
  end
end
