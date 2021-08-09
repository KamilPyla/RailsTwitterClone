# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:post) { FactoryBot.create(:user).microposts.build(content: 'Something') }

  it 'should be valid with correct values' do
    expect(post).to be_valid
  end
  it 'only users might create microposts' do
    micropost = Micropost.new(content: 'Loren Ipsum')
    expect(micropost).to be_invalid
  end
  context 'content validation tests' do
    it 'can not be empty' do
      post.content = ''
      expect(post).to be_invalid
    end
    it 'can not be blank' do
      post.content = '    '
      expect(post).to be_invalid
    end
  end
end

def user
  user = User.new(name: 'example', email: 'user@example.com', password: 'password', password_confirmation: 'password',
                  gender: 'm')
  user.save
  user
end
