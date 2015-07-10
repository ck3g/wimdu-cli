require 'spec_helper'

RSpec.describe Wimdu::Property do
  describe '#create' do
    it "creates new property" do
      expect {
        Wimdu::Property.create slug: 'ABC1DEF2',
                               title: 'Amazing Room at Wimdu Office'
      }.to change(Wimdu::Property, :count).by 1
    end
  end
end
