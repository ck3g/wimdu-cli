require 'spec_helper'

RSpec.describe Wimdu::Property do
  describe '.validation' do
    context 'when valid' do
      subject { Wimdu::Property.create guests: 2 }
      it do
        is_expected.to validate_numericality_of(:guests)
          .with_message 'must be a number'
      end
      it do
        is_expected.to validate_inclusion_of(:property_type)
          .in_array(['holiday home', 'apartment', 'private room'])
          .with_message 'must be one of: holiday home, apartment, private room'
      end
      it do
        is_expected.to validate_numericality_of(:nightly_rate)
          .with_message 'must be a number'
      end
    end

    context 'when invalid' do
      subject { Wimdu::Property.new }
      it { is_expected.to allow_value('').for :guests }
      it { is_expected.to allow_value('').for :property_type }
      it { is_expected.to allow_value('').for :nightly_rate }
    end
  end

  describe '.create' do
    it "creates new property" do
      expect {
        Wimdu::Property.create slug: 'ABC1DEF2',
                               title: 'Amazing Room at Wimdu Office'
      }.to change(Wimdu::Property, :count).by 1
    end
  end

  describe '.create_uniq' do
    it "creates new property" do
      expect {
        Wimdu::Property.create_uniq
      }.to change(Wimdu::Property, :count).by 1
    end

    it "creates new property with unique slug" do
      Wimdu::Property.create_uniq
      expect(Wimdu::Property.last.slug).to be_truthy
    end
  end

  describe '#missing_fields' do
    subject { property.missing_fields }

    context 'when property has no persisted fields' do
      let!(:property) { Wimdu::Property.create_uniq }

      it do
        is_expected.to eq %i(title address guests property_type
                             nightly_rate email phone)
      end
    end

    context 'when property has title' do
      let!(:property) { Wimdu::Property.create title: 'Awesome Room' }

      it do
        is_expected.to eq %i(address guests property_type
                             nightly_rate email phone)
      end
    end
  end
end
