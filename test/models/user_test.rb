require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com', password: 'jakies_haslo', password_confirmation: 'jakies_haslo')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = "     "
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = "exaple" * 50
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = "     "
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'example' * 100 + "@sth.com"
    assert_not @user.valid?
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email should be saved as lower-case' do
    email = 'KksDwDgtwdfaA@BlablA.cOm'
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end


  test 'password shoult not be blank' do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test 'password should have a minimum lenght' do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Some content')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
