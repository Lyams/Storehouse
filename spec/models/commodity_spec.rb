require 'rails_helper'

RSpec.describe Commodity, type: :model do
  subject {build :commodity}
  describe 'attributes' do
    it { is_expected.to respond_to(:name) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }
    it { is_expected.to be_valid }
  end
end
