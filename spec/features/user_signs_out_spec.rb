require 'spec_helper'
require_relative 'helpers/session'

feature "User signs out" do 

include SessionHelpers

	before(:each) do
		 User.create(:email => "test@test.com",
	    :password => 'test',
	    :password_confirmation => 'test')
	end

	scenario "whilst being signed in" do 
		sign_in('test@test.com', 'test')
		click_button 'Sign Out'
		expect(page).to have_content("Goodbye!")
		expect(page).not_to have_content("Welcome, test@test.com")
	end


end