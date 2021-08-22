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
    it { is_expected.to belong_to :shipment }
    it { is_expected.to belong_to :commodity }
    it { is_expected.to have_db_column(:shipment_id).of_type(:integer) }
    it { is_expected.to have_db_column(:shipment_type).of_type(:string) }
  end
end
