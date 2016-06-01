require 'rails_helper'

RSpec.describe 'Sign In', type: :request do
  describe 'GET /sign-in' do
    let(:user_active)  { create(:user) }
    let(:user_blocked) { create(:user_blocked) }
    let(:user_admin)   { create(:user_admin) }

    it 'open sign in page' do
      visit sign_in_path
      expect(page).to have_content('Sign In')
    end

    it 'login by active user' do
      visit sign_in_path

      fill_in 'Email', with: user_active.email
      fill_in 'Password', with: DEFAULT_PASSWORD
      click_button 'Sign In'

      expect(page).to have_content('Dashboard')
    end

    it 'login by blocked user' do
      visit sign_in_path

      fill_in 'Email', with: user_blocked.email
      fill_in 'Password', with: DEFAULT_PASSWORD
      click_button 'Sign In'

      expect(page).to have_content('Your account not activated yet')
    end

    it 'login by admin user' do
      visit sign_in_path

      fill_in 'Email', with: user_admin.email
      fill_in 'Password', with: DEFAULT_PASSWORD
      click_button 'Sign In'

      expect(page).to have_content('Dashboard')
    end

    it 'login with wrong credentials' do
      visit sign_in_path

      fill_in 'Email', with: user_active.email
      fill_in 'Password', with: '87654321'
      click_button 'Sign In'

      expect(page).to have_content('Email or password is wrong')
    end
  end
end
