$:.unshift(File.join(File.dirname(__FILE__), '..', '..', 'models'))
$:.unshift(File.join(File.dirname(__FILE__), '..', '..', 'test'))

require 'test_helper'
require 'minitest/autorun'
require 'init'

class UserTest < MiniTest::Unit::TestCase
  def setup
    DatabaseCleaner.start
    @user = User.new
  end

  def teardown
     DatabaseCleaner.clean
  end

  def test_that_a_username_is_required
    @user.password = 'password'
    assert_equal @user.valid?, false
    @user.username = 'username'
    assert_equal @user.valid?, true
  end

  def test_that_the_password_is_hashed_on_save
    @user.username = 'username'
    @user.password = 'password'
    @user.save
    persisted_user = User.first(:conditions => {:username => 'username'})
    refute_nil persisted_user.password_hash
    refute_nil persisted_user.password_salt
  end

  def test_that_a_user_can_be_authenticated
    @user.username = 'username'
    @user.password = 'password'
    @user.save
    valid_user = User.authenticate('username','password')
    refute_nil valid_user
    assert_equal valid_user.username, 'username'
  end
end
