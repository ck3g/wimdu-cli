require 'spec_helper'

RSpec.describe Wimdu::OptionHandler::List do
  describe '#run' do
    context 'when there is available properties' do
      let(:property) do
        Wimdu::Property.create slug: 'ABC1DEF2',
                               title: 'Amazing Room at Wimdu Office'
      end

      before do
        allow(Wimdu::Property).to receive(:all).and_return [property]
      end

      it 'outputs summary' do
        expect { subject.run }.to output(/Found 1 offer./).to_stdout
      end

      it "outputs property details" do
        expect { subject.run }
          .to output(/ABC1DEF2: Amazing Room at Wimdu Office/).to_stdout
      end
    end

    context 'when there is no available properties' do
      it 'outputs "No offers found".to stdout' do
        expect { subject.run }.to output("No offers found.\n").to_stdout
      end
    end
  end
end
