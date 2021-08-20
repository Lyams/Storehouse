require 'rails_helper'

RSpec.describe Thing, type: :model do
  subject {build :thing}
  describe 'attributes' do
    it { is_expected.to respond_to(:value) }
  end
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:value).only_integer.is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to be_valid }
  end
  describe 'association' do
    it { is_expected.to belong_to :storehouse }
    it { is_expected.to belong_to :commodity }
  end
end
