$:.unshift(File.join(File.dirname(__FILE__), '..', '..'))
$:.unshift(File.join(File.dirname(__FILE__), '..', '..','test'))

require 'minitest/autorun'
require 'capybara'
require 'capybara/dsl'
require 'rack/test'
require 'test_helper'

require 'app'

class RegistrationTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  include Capybara::DSL

  Capybara.app = Moola

  def setup
    DatabaseCleaner.start
    @user = User.new
  end

  def teardown
     DatabaseCleaner.clean
  end

  def test_successful_registration
    visit '/users/new'
    fill_in 'username', :with => 'username'
    fill_in 'password', :with => 'password'
    click_on 'Create my account'
    assert page.has_content? 'Dashboard'
  end

  def test_unsuccessful_registration
    visit '/users/new'
    fill_in 'username', :with => 'username'
    click_on 'Create my account'
    assert page.has_content? 'Problem with username/password'
    fill_in 'password', :with => 'passw'
    click_on 'Create my account'
    assert page.has_content? 'Problem with username/password'
  end
end
