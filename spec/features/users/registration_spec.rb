require 'rails_helper'

feature 'Registration' do

  let(:user_attributes) { attributes_for(:user) }

  before do
    visit '/sign_up'

    fill_in 'user_first_name', with: user_attributes[:first_name]
    fill_in 'user_last_name', with: user_attributes[:last_name]
    fill_in 'user_email', with: user_attributes[:email]
    fill_in 'user_password', with: user_attributes[:password]
    fill_in 'user_password_confirmation', with: user_attributes[:password]

    click_on 'Sign up'
  end

  scenario 'with valid inputs' do
    click_on 'Sign out'
    login_page = LoginPage.new
    login_page.visit('/sign_in')
    login_page.sign_in(user_attributes[:email], user_attributes[:password])

    expect(page).to have_content('Sign out')
  end

  scenario 'sign-in upon account creation' do
    expect(page).to have_content('Sign out')
  end

end