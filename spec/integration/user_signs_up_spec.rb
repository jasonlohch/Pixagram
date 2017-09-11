require 'rails_helper'

feature 'user creates new profile' do
  scenario "succesfully creates profile" do
  	visit root_path
  	click_link "Sign Up"
  	fill_in "Name", with: "Jason"
  	fill_in "Email", with: "jason@mail.com"
  	fill_in "Password", with: "123456"
  	fill_in "Confirm Your Password", with: "123456"
  	click_button "Create my account"
  	page.should have_content "Profile Page"
  end
end