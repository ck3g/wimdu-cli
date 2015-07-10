require 'spec_helper'

RSpec.describe Wimdu::Property do
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

      it { is_expected.to eq %i(title address) }
    end

    context 'when property has title' do
      let!(:property) { Wimdu::Property.create title: 'Awesome Room' }

      it { is_expected.to eq %i(address) }
    end
  end
end
