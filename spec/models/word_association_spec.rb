require 'rails_helper'

RSpec.describe WordAssociation, type: :model do
  subject { build(:word_association) }

  context 'associations' do
    it { is_expected.to belong_to(:word) }
    it { is_expected.to belong_to(:related_word) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:word_id).scoped_to(:related_word_id) }
  end
end
