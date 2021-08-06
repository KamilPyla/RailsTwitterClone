require 'rails_helper'


RSpec.describe User, type: :model do
  subject {
    User.new(name: "Exaple",
            email: 'example@user.com',
            password: 'password',
            password_confirmation: 'password',
            gender: 'm')
  }

  it 'is valid with correct attributes' do
    expect(subject).to be_valid  
  end

  context 'name validation tests' do
    it 'can not be empty' do
      subject.name = ''
      expect(subject).to be_invalid
    end
    it 'can not be blank' do
      subject.name = '    '
      expect(subject).to be_invalid
    end
    it 'can not be too long' do
      subject.name = "exaple" * 50
      expect(subject).to be_invalid
    end
  end

  context 'email validation tests' do
    it 'must contain @ sign' do
      subject.email = 'example.com'
      expect(subject).to be_invalid
    end
    it 'can not be blank' do
      subject.email = '   '
      expect(subject).to be_invalid
    end
    it 'can not be longer than 255 letters' do
      subject.email = "abcd"*63 + '@example.com'
      expect(subject).to be_invalid
    end
    it 'email addresses should be unique' do
      user = subject.dup
      user.save
      expect(subject).to be_invalid
      subject.email = subject.email.upcase
      expect(subject).to be_invalid
    end 
    it 'correct email must be valid' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        subject.email = valid_address
        expect(subject).to be_valid
      end
    end
    it 'must be saved as lower case string' do
      email = 'ExaMPLE@uSER.CoM'
      subject.email = email
      subject.save
      expect(subject.email).to eq(email.downcase)
    end
  end
    
  context 'gender validation tests' do
    it 'can not be blank' do
      subject.gender = ' '
      expect(subject).to be_invalid
    end
    it 'must be valid with value m' do
      subject.gender = 'm'
      expect(subject).to be_valid
    end
    it 'must be valid with value f' do
      subject.gender = 'f'
      expect(subject).to be_valid
    end
    it 'must be invalid with incorrect value' do
      subject.gender = 'blablabla'
      expect(subject).to be_invalid
    end
  end

  context 'password validation tests' do
    it 'can not be blank' do
      subject.password = ' ' * 6
      subject.password_confirmation = ' ' * 6
      expect(subject).to be_invalid
    end
    it 'should have minimum lenght' do
      subject.password = 'blabl'
      subject.password_confirmation = 'blabl'
      expect(subject).to be_invalid
    end

    it 'password confirmation must be the same' do
      subject.password = 'blablabla'
      subject.password_confirmation = 'foobalbalbal'
      expect(subject).to be_invalid 
    end
  end


  # it 'is valid with valid attributes' do
  # end
  # it 'is valid with valid attributes' do
  # end
  # it 'is valid with valid attributes' do
  # end
  # it 'is valid with valid attributes' do
  # end
  # it 'is valid with valid attributes' do
  # end
  # it 'is valid with valid attributes' do
  # end
end
