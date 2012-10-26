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

  def test_that_a_password_is_required
    @user.username = 'username'
    assert_equal @user.valid?, false
    @user.password = 'password'
    assert_equal @user.valid?, true
  end

  def test_that_a_valid_user_has_a_username_and_password
    @user.username = 'username'
    @user.password = 'password'
    assert_equal @user.valid?, true
  end
end
