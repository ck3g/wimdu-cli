require 'spec_helper'

RSpec.describe Wimdu::OptionHandler::Continue do
  describe '#run' do
    subject { Wimdu::OptionHandler::Continue.new(slug).run }

    before do
      allow(STDIN).to receive(:gets)
        .and_return("Central Street", '2', 'apartment',
                    '12', 'john.doe@example.com', '+1 123 45678')
    end

    context 'when invalid property slug' do
      let(:slug) { 'invalid' }

      it "displays error message" do
        expect { subject }.to output(/Invalid property./).to_stdout
      end
    end

    context 'when property exists' do
      let(:slug) { property.slug }

      context 'when property is draft' do
        let!(:property) do
          property = Wimdu::Property.create_uniq
          property.update title: 'Awesome Room'
          property
        end

        it "skip existing fields" do
          expect { subject }.not_to output(/Title: /).to_stdout
        end

        it "continue from missing fields" do
          expect { subject }.to output(/Address: /).to_stdout
        end

        it "updates property address" do
          expect {
            subject
            property.reload
          }.to change { property.address }.to 'Central Street'
        end
      end

      context 'when property is published' do
        let!(:property) do
          property = Wimdu::Property.create_uniq
          property.update title: 'Awesome Room'
          property.publish!
          property
        end

        it "displays error message" do
          expect { subject }.to output(/Invalid property./).to_stdout
        end
      end
    end
  end
end
