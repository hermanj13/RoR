require 'rails_helper'

RSpec.describe Borrower, type: :model do
  context 'strong password:' do
    it 'password must be 8 characters' do
      user = Borrower.create(first: 'Jake',last: 'Herman', email: 'test@test.com',password: 'fail1', password_confirmation: 'fail1',money: 100,purpose: 'fun', description: 'lets roll', raised: 0)
      expect(user).to be_invalid
    end
    it 'password must containt number' do
      user = Borrower.create(first: 'Jake',last: 'Herman', email: 'test@test.com',password: 'failfail', password_confirmation: 'failfail', money: 100, purpose: 'fun', description: 'lets roll', raised: 0)
      expect(user).to be_invalid
    end
    it 'should save' do
      user = Borrower.create(first: 'Jake',last: 'Herman', email: 'test@test.com',password: 'success1', password_confirmation: 'success1', money: 100, purpose: 'fun', description: 'lets roll', raised: 0)
      expect(user).to be_valid
    end
  end
end
