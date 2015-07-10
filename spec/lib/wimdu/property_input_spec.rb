require 'spec_helper'

RSpec.describe Wimdu::PropertyInput do
  describe '#perform' do
    subject { Wimdu::PropertyInput.new(property).perform }

    let(:slug) { Wimdu::SlugGenerator.generate }

    context 'when property has no missing fields' do
      let!(:property) do
        Wimdu::Property.create slug: slug,
                               title: 'Awesome Room',
                               address: 'Central Street',
                               guests: 2,
                               property_type: 'apartment',
                               nightly_rate: 12,
                               email: 'john.doe@example.com',
                               phone: '+1 123 45678'
      end

      it "displays success message" do
        expect { subject }
          .to output(%r{Great job! Listing #{slug} is complete!})
          .to_stdout
      end

      it "publish property" do
        expect {
          subject
          property.reload
        }.to change { property.status }.from('draft').to 'published'
      end
    end

    context 'when property has missing fields' do
      let!(:property) do
        Wimdu::Property.create slug: slug
      end

      before do
        allow(STDIN).to receive(:gets).and_return ""
      end

      it "do not display success message" do
        expect { subject }.not_to output(%r{Great job!}).to_stdout
      end
    end

    context 'when field fails with validation error' do
      let!(:property) do
        Wimdu::Property.create slug: slug,
                               title: 'Awesome Room',
                               address: 'Central Street'
      end

      before do
        allow(STDIN).to receive(:gets)
          .and_return("two", '2', 'apartment',
                      '12', 'john.doe@example.com', '+1 123 45678')
      end

      it "display error message for missing field" do
        expect { subject }.to output(/Error: must be a number/).to_stdout
      end
    end
  end
end
