require 'rails_helper'

RSpec.describe Storehouse, type: :model do
  subject {build :storehouse}
  describe 'attributes' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to enumerize(:district).in(:central,
                                              :northwestern, :southern, :north_caucasian,
                                              :volga, :ural, :siberian, :far_eastern)}
  end
  describe 'association' do
    it { is_expected.to have_many :things }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(2) }
    it { is_expected.to be_valid }
  end
end
