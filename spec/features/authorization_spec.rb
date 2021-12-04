require 'rails_helper'

signin_success_message = "Signed in successfully"
signup_success_message = "Welcome! You have signed up successfully"
presence_error = " can't be blank"
uniqueness_error = " has already been taken"
minimum_char_error = " is too short"
confirmation_error = "Password confirmation doesn't match Password"
email_error = "Email is invalid"

RSpec.describe Task, type: :feature do
    before(:all) do
        User.destroy_all
    end

    let(:valid_attributes) {
        {email: "email@email.com",
        password: "P@ssw0rd"}
    }

    let(:invalid_attributes_1) {
        {email: "email",
        password: "P@ssw0rd"}
    }

    let(:invalid_attributes_2) {
        {email: "email@email.com",
        password: "P@ss"}
    }

    describe "9. Create user account to have own user credentials" do
        context "with valid parameters" do
            it "signs up user" do
                visit '/categories'
                click_on 'Sign up'

                expect(page).to have_current_path new_user_registration_path

                fill_in 'Email', with: valid_attributes[:email]
                fill_in 'Password', with: valid_attributes[:password]
                fill_in 'Password confirmation', with: valid_attributes[:password]
                
                click_on 'Sign up'
                
                expect(page).to have_current_path categories_path
                expect(page).to have_content signup_success_message
            end
        end

        context "with invalid parameters" do
            it 'is not valid without an email' do
                visit "/users/sign_up"

                fill_in 'Password', with: valid_attributes[:password]
                fill_in 'Password confirmation', with: valid_attributes[:password]
                
                click_on 'Sign up'
                
                expect(page).to have_current_path user_registration_path
                expect(page).to have_content ("Email#{presence_error}")
            end
    
            it 'is not valid when password confirmation does not match password' do
                visit "/users/sign_up"

                fill_in 'Email', with: invalid_attributes_2[:email]
                fill_in 'Password', with: valid_attributes[:password]
                fill_in 'Password confirmation', with: invalid_attributes_2[:password]
                
                click_on 'Sign up'
                
                expect(page).to have_current_path user_registration_path
                expect(page).to have_content confirmation_error
            end
    
            it 'is not valid when email is not valid' do
                visit "/users/sign_up"

                fill_in 'Email', with: invalid_attributes_1[:email]
                fill_in 'Password', with: invalid_attributes_1[:password]
                fill_in 'Password confirmation', with: invalid_attributes_1[:password]
                
                click_on 'Sign up'
                
                expect(page).to have_current_path user_registration_path
                expect(page).to have_content email_error
            end

            it 'is not valid when password has less than 6 characters' do
                visit "/users/sign_up"

                fill_in 'Email', with: invalid_attributes_2[:email]
                fill_in 'Password', with: invalid_attributes_2[:password]
                fill_in 'Password confirmation', with: invalid_attributes_2[:password]
                
                click_on 'Sign up'
                
                expect(page).to have_current_path user_registration_path
                expect(page).to have_content ("Password#{minimum_char_error}")
            end

            it 'is not valid when email is already taken' do
                create(:user)
                visit "/users/sign_up"

                fill_in 'Email', with: valid_attributes[:email]
                fill_in 'Password', with: valid_attributes[:password]
                fill_in 'Password confirmation', with: valid_attributes[:password]
                
                click_on 'Sign up'
                
                expect(page).to have_current_path user_registration_path
                expect(page).to have_content ("Email#{uniqueness_error}")
            end
        end
    end
end