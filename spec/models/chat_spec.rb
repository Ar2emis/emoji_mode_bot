# frozen_string_literal: true

RSpec.describe Chat, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:memberships).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:memberships) }
    it { is_expected.to have_many(:bans).dependent(:destroy) }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:telegram_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:emoji_mode).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:air_alert_mode).of_type(:boolean).with_options(default: false) }
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end

  describe 'indicies' do
    it { is_expected.to have_db_index(:telegram_id) }
  end

  describe '.ransackable_scopes' do
    let(:scope) { :search_by_title }

    it 'returns pg_search search_by_title scope' do
      expect(described_class.ransackable_scopes).to include(scope)
    end
  end
end
