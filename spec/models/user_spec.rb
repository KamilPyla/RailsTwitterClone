require 'rails_helper'


RSpec.describe User, type: :model do
  let(:user) {
    User.new(name: "Exaple",
            email: 'examplee@user.com',
            password: 'password',
            password_confirmation: 'password',
            gender: 'm')
  }

  it 'is valid with correct attributes' do
    expect(user).to be_valid  
  end

  context 'name validation tests' do
    it 'can not be empty' do
      user.name = ''
      expect(user).to be_invalid
    end
    it 'can not be blank' do
      user.name = '    '
      expect(user).to be_invalid
    end
    it 'can not have more than 50 letters' do
      user.name = "exaple" * 50
      expect(user).to be_invalid
    end
  end

  context 'email validation tests' do
    it 'must contain @ sign' do
      user.email = 'example.com'
      expect(user).to be_invalid
    end
    it 'can not be blank' do
      user.email = '   '
      expect(user).to be_invalid
    end
    it 'can not be longer than 255 letters' do
      user.email = "abcd"*63 + '@example.com'
      expect(user).to be_invalid
    end
    it 'email addresses should be unique' do
      user_temp = user.dup
      user_temp.save
      expect(user).to be_invalid
      user.email = user.email.upcase
      expect(user).to be_invalid
    end 
    it 'correct email must be valid' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
    it 'must be saved as lower case string' do
      email = 'ExaMPLE@uSERr.CoM'
      user.email = email
      user.save
      expect(user.email).to eq(email.downcase)
    end
  end
    
  context 'gender validation tests' do
    it 'can not be blank' do
      user.gender = ' '
      expect(user).to be_invalid
    end
    it 'should be valid with value m' do
      user.gender = 'm'
      expect(user).to be_valid
    end
    it 'should be valid with value f' do
      user.gender = 'f'
      expect(user).to be_valid
    end
    it 'should be invalid with incorrect value' do
      user.gender = 'blablabla'
      expect(user).to be_invalid
    end
  end

  context 'password validation tests' do
    it 'can not be blank' do
      user.password = ' ' * 6
      user.password_confirmation = ' ' * 6
      expect(user).to be_invalid
    end
    it 'should have minimum lenght' do
      user.password = 'blabl'
      user.password_confirmation = 'blabl'
      expect(user).to be_invalid
    end

    it 'password confirmation must be the same' do
      user.password = 'blablabla'
      user.password_confirmation = 'foobalbalbal'
      expect(user).to be_invalid 
    end
  end
end
