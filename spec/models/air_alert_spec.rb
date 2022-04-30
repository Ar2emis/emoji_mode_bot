# frozen_string_literal: true

RSpec.describe AirAlert, type: :model do
  describe 'columns' do
    it { is_expected.to have_db_column(:places).of_type(:string).with_options(array: true, default: []) }
  end
end
