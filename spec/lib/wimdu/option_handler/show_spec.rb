require 'spec_helper'

RSpec.describe Wimdu::OptionHandler::Show do
  describe '#run' do
    subject { Wimdu::OptionHandler::Show.new('ABC1DEF2') }

    context 'when there is available properties' do
      let!(:property) do
        Wimdu::Property.create slug: 'ABC1DEF2',
                               title: 'Amazing Room at Wimdu Office',
                               status: 'published'
      end

      it "outputs property details" do
        expect { subject.run }
          .to output(/Title: Amazing Room at Wimdu Office/).to_stdout
      end
    end

    context 'when property is not exists' do
      it 'outputs "No offers found".to stdout' do
        expect { subject.run }.to output("No offers found.\n").to_stdout
      end
    end
  end
end
