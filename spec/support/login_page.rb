class LoginPage
  include Capybara::DSL

  def sign_in(email, password)
    visit '/sign_in'
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end
end