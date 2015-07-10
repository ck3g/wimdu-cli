require 'spec_helper'

RSpec.describe Wimdu::PropertyInput do
  describe '#perform' do
    subject { Wimdu::PropertyInput.new(property).perform }

    let(:slug) { Wimdu::SlugGenerator.generate }

    context 'when property has no missing fields' do
      let!(:property) do
        Wimdu::Property.create slug: slug,
                               title: 'Awesome Room',
                               address: 'Central Street'
      end

      it "displays success message" do
        expect { subject }
          .to output(%r{Great job! Listing #{slug} is complete!})
          .to_stdout
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
  end
end
