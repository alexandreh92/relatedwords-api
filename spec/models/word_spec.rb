require 'rails_helper'

RSpec.describe Word, type: :model do
  subject { build(:word) }

  context 'associations' do
    it { is_expected.to have_many(:word_associations) }
    it { is_expected.to have_many(:related_words).through(:word_associations) }

    it { is_expected.to have_many(:associated_words).with_foreign_key(:related_word_id).class_name('WordAssociation') }
    it { is_expected.to have_many(:parent_words).through(:associated_words).source(:word) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_uniqueness_of(:value) }
    it { is_expected.not_to allow_value(nil).for(:score) }
  end
end
