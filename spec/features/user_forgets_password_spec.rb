require 'spec_helper'
require_relative 'helpers/session'

feature "User forgets password" do 

include SessionHelpers

	before(:each) do
		 User.create(:email => "test@test.com",
	    :password => 'test',
	    :password_confirmation => 'test')
	end

	scenario "requests token email" do
		visit '/sessions/new'
		expect(page).not_to have_content("Welcome, test@test.com")
		click_button 'Forgotten Password'
		fill_in :email, :with => 'test@test.com'
		click_button "Send Reset Link"
		expect(page).to have_content('An email has been sent to you.')
	end
end