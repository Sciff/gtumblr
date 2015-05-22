require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { build(:location) }

  subject{ location }

  it{ is_expected.to be_valid }

  it 'should be invalid without address' do
    location.address = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without latitude' do
    location.latitude = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without longitude' do
    location.longitude = nil
    is_expected.not_to be_valid
  end

  it 'should be invalid without users' do
    location.user = nil
    is_expected.not_to be_valid
  end

  it 'should set title from address if title blank' do
    location.title = nil
    location.valid?
    expect(location.title).to eq(location.address)
  end

end
