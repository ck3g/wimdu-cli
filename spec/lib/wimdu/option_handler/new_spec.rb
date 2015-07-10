require 'spec_helper'

RSpec.describe Wimdu::OptionHandler::New do
  describe '#run' do
    subject { Wimdu::OptionHandler::New.new.run }

    before do
      allow(STDIN).to receive(:gets)
        .and_return "Awesome Room", "Central Street"
    end

    it "outputs prompt with new Property slug" do
      slug = SecureRandom.hex(4).upcase
      allow_any_instance_of(Wimdu::Property).to receive(:slug)
        .and_return slug

      expect { subject }
        .to output(%r{Starting with new property #{slug}.})
        .to_stdout
    end

    it "generates new property" do
      expect { subject }.to change(Wimdu::Property, :count).by 1
    end

    it "updates property title" do
      subject
      expect(Wimdu::Property.last.title).to eq 'Awesome Room'
    end

    it "updates property address" do
      subject
      expect(Wimdu::Property.last.address).to eq 'Central Street'
    end
  end
end
