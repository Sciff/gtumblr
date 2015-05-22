require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  subject{ user }

  it { is_expected.to be_valid }

  it 'should be invalid without email' do
    user.email = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without first name' do
    user.first_name = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without last name' do
    user.last_name = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without password' do
    user.password = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without password_confirmation' do
    user.password_confirmation = user.password * 2
    is_expected.not_to be_valid
  end

  it 'should require password' do
    expect(user.password_required?).to be_truthy
  end

  it 'should not require password if provider present' do
    user.provider = 'twitter'
    expect(user.password_required?).to be_falsey
  end

  context 'with provider' do

    before { user.provider  = 'twitter' }

    describe 'new user' do

      it 'should not require first name ' do
        user.first_name = nil
        is_expected.to be_valid
      end

      it 'should not require last name ' do
        user.last_name = nil
        is_expected.to be_valid
      end

      it 'should not require password' do
        user.provider = 'twitter'
        expect(user.password_required?).to be_falsey
      end
    end

    describe 'existed user' do
      before { user.save! }

      it 'should require first name ' do
        user.first_name = nil
        is_expected.not_to be_valid
      end

      it 'should require last name ' do
        user.last_name = nil
        is_expected.not_to be_valid
      end

      it 'should require password' do
        user.provider = 'twitter'
        expect(user.password_required?).to be_truthy
      end
    end
  end

end
