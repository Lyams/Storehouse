require 'rails_helper'

RSpec.describe Storehouse, type: :model do
  subject {build :storehouse}
  describe 'attributes' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to enumerize(:district).in(:central,
                                              :northwestern, :southern, :north_caucasian,
                                              :volga, :ural, :siberian, :far_eastern)}
  end
end
