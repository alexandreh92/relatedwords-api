require 'rails_helper'

RSpec.describe Word, type: :model do
  subject { build(:word) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_uniqueness_of(:value) }
  it { is_expected.not_to allow_value(nil).for(:score) }
end
