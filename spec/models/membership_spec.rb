# frozen_string_literal: true

RSpec.describe Membership, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chat) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:user_id).of_type(:uuid).with_options(null: false) }
    it { is_expected.to have_db_column(:chat_id).of_type(:uuid).with_options(null: false) }
    it { is_expected.to have_db_column(:role).of_type(:integer).with_options(default: :regular) }
  end

  describe 'indicies' do
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:chat_id) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(regular: 0, admin: 1).with_suffix(true) }
  end

  describe '.decorator_class' do
    let(:decorator) { Telegram::V1::User::Membership::Decorator }

    it 'returns default decorator' do
      expect(described_class.decorator_class).to eq(decorator)
    end
  end
end
