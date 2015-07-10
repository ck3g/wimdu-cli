require 'spec_helper'

RSpec.describe Wimdu::OptionHandler::Continue do
  describe '#run' do
    subject { Wimdu::OptionHandler::Continue.new(slug).run }

    before do
      allow(STDIN).to receive(:gets)
        .and_return "Central Street"
    end

    context 'when invalid property slug' do
      let(:slug) { 'invalid' }

      it "displays error message" do
        expect { subject }.to output(/Invalid property./).to_stdout
      end
    end
  end
end
