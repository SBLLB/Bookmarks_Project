require 'spec_helper'
require_relative 'helpers/session'

feature "User forgets password" do 

include SessionHelpers

	before(:each) do
		 User.create(:email => "mail@rachelnolan.com",
	    :password => 'test',
	    :password_confirmation => 'test')
	end

	scenario "requests token email" do
		visit '/sessions/new'
		expect(page).not_to have_content("Welcome, test@test.com")
		click_button 'Forgotten Password'
		fill_in :email, :with => 'mail@rachelnolan.com'
		click_button "Send Reset Link"
		expect(page).to have_content('An email has been sent to you.')
	end

	scenario "does not allow token email request if not registered" do
		visit '/sessions/new'
		expect(page).not_to have_content("Welcome, test@test.com")
		click_button 'Forgotten Password'
		fill_in :email, :with => 'bob@rachelnolan.com'
		click_button "Send Reset Link"
		expect(page).to have_content('You are not registered on this site')
	end

end