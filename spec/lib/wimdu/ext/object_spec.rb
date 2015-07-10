require 'spec_helper'

RSpec.describe Object do
  describe '#blank?' do
    subject { object.blank? }

    context 'when object is nil' do
      let(:object) { nil }
      it { is_expected.to be_truthy }
    end

    context 'when object is empty string' do
      let(:object) { "" }
      it { is_expected.to be_truthy }
    end

    context 'when object is valid string' do
      let(:object) { "I exist" }
      it { is_expected.to be_falsey }
    end
  end
end
