# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:chats).through(:memberships) }
    it { is_expected.to have_many(:bans).dependent(:destroy) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:telegram_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:bot).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:first_name).of_type(:string).with_options(default: '') }
    it { is_expected.to have_db_column(:last_name).of_type(:string).with_options(default: '') }
    it { is_expected.to have_db_column(:username).of_type(:string) }
  end

  describe 'indicies' do
    it { is_expected.to have_db_index(:telegram_id) }
  end

  describe '.ransackable_scopes' do
    let(:scope) { :search_by_name }

    it 'returns pg_search search_by_name scope' do
      expect(described_class.ransackable_scopes).to include(scope)
    end
  end

  describe '.decorator_class' do
    let(:decorator) { Telegram::V1::User::Decorator }

    it 'returns default decorator' do
      expect(described_class.decorator_class).to eq(decorator)
    end
  end
end
