require 'rails_helper'
feature 'User Features' do
  feature 'errors for incorect registration' do
    scenario 'visits register page' do
      visit "/register"
      fill_in 'Lender First', with: ''
      fill_in 'Lender Last', with: ''
      fill_in 'Lender Email', with: ''
      fill_in 'Lender Password', with: ''
      fill_in 'Lender Password Confirmation', with: ''
      fill_in 'Lender Money', with: ''
      click_button 'Lender Register'
      expect(page).to have_content "First can't be blank"
      expect(page).to have_content "Last can't be blank"
      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Email is invalid"
      expect(page).to have_content "Password can't be blank"
      expect(page).to have_content "Money can't be blank"
    end
  end
  feature 'borrow route has correct info' do
    scenario 'registers and goes to barrowers page' do
      visit "/register"
      fill_in 'Borrower First', with: 'Jake'
      fill_in 'Borrower Last', with: 'Herman'
      fill_in 'Borrower Email', with: 'test@tet.com'
      fill_in 'Borrower Password', with: 'test1234'
      fill_in 'Borrower Password Confirmation', with: 'test1234'
      fill_in 'Borrower Purpose', with: 'fun'
      fill_in 'Borrower Description', with: 'fun'
      fill_in 'Borrower Money', with: '1000'
      click_button 'Borrower Register'
      expect(page).to have_content "Name: Jake Herman"
      expect(page).to have_content "Amount Needed: $1000"
      expect(page).to have_content "Amount Raised: $0"
    end
  end
end
