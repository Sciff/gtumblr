require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  subject{ user }

  it { is_expected.to be_valid }

  it 'should be invalid without first name' do
    user.first_name = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without last name' do
    user.last_name = nil
    is_expected.not_to be_valid
  end

end
