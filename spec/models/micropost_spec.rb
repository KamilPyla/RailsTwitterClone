require 'rails_helper'


RSpec.describe Micropost, type: :model do

  user = User.new(name:'example', email: 'example@user.com', password: 'password', password_confirmation: 'password', gender:'m')
  user.save
  subject { user.microposts.build(content: 'Aperiam cumque tempora voluptas.') }

  it 'should be valid with correct values' do
    expect(subject).to be_valid
  end  
  it 'only users might create microposts' do
    expect(Micropost(content:'something')).to be_invalid
  end
    context 'content validation tests' do
    it 'can not be empty' do
      subject.content = ''
      expect(subject).to be_invalid  
    end
    it 'can not be blank' do
      subject.content = '    '
    end
  end
end
