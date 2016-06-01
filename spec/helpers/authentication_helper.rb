module AuthenticationHelper
  def sign_in_by(user)
    visit sign_in_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: DEFAULT_PASSWORD
    click_button 'Sign In'
  end
end
