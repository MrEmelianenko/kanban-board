require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  describe 'create the project' do
    before(:each) do
      sign_in_by(create(:user))
    end

    it 'successfully' do
      visit new_project_path
      expect(page).to have_content('New Project')

      fill_in 'Name', with: FFaker::Product.name
      fill_in 'Description', with: FFaker::Product.product_name
      click_button 'Create Project'

      expect(page).to have_content('Project successfully created')
    end

    it 'with empty name' do
      visit new_project_path
      expect(page).to have_content('New Project')

      fill_in 'Description', with: FFaker::Product.product_name
      click_button 'Create Project'

      expect(page).to have_content('Name can\'t be blank')
    end
  end
end
