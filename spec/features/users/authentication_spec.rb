require 'rails_helper'

shared_examples 'omniauth sign up' do
  scenario 'sign_up' do

    fill_in 'user_email', with: Faker::Internet.email

    click_on 'Sign up'

    expect(page).to have_content('Sign out')

    expect(page).to  have_content('Welcome! You have signed up successfully.')
  end
end

feature 'Authentication' do
  let(:login_page) { LoginPage.new }
  let(:user) { create(:user) }

  feature 'sign in with email and password' do
    before do
      login_page.sign_in(user.email, user.password)
    end

    scenario 'with valid inputs' do
      expect(page).to have_content('Sign out')
    end

    scenario 'redirect after login' do
      expect(page).to  have_content(user.first_name)
    end
  end

  feature 'sign in with twitter' do
    before do
      visit 'users/auth/twitter'
    end
    it_behaves_like 'omniauth sign up'
  end

  feature 'sign in with facebook' do
    before do
      visit 'users/auth/facebook'
    end
    it_behaves_like 'omniauth sign up'
  end

  feature 'sign in with vkontakte' do
    before do
      visit 'users/auth/vkontakte'
    end
    it_behaves_like 'omniauth sign up'
  end

end


