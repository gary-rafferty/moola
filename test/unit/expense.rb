$:.unshift(File.join(File.dirname(__FILE__), '..', '..', 'models'))
$:.unshift(File.join(File.dirname(__FILE__), '..', '..', 'test'))

require 'test_helper'
require 'minitest/autorun'
require 'init'

class ExpenseTest < MiniTest::Unit::TestCase
  def setup
    DatabaseCleaner.start
    @expense = Expense.new
  end

  def teardown
     DatabaseCleaner.clean
  end

  def test_that_an_amount_is_required
    @expense.recurring = false
    assert_equal @expense.valid?, false
    @expense.amount = 15.05
    assert_equal @expense.valid?, true
  end

  def test_that_a_time_is_optional
    @expense.recurring = true
    @expense.amount = 15.05
    assert_equal @expense.valid?, true
    @expense.when = Time.now
    assert_equal @expense.valid?, true
  end

  def test_that_a_description_is_optional
    @expense.recurring = true
    @expense.amount = 15.05
    assert_equal @expense.valid?, true
    @expense.description = 'Some description'
    assert_equal @expense.valid?, true
  end

  def test_that_recurring_boolean_is_required
    @expense.amount = 15.05
    assert_equal @expense.valid?, false
    @expense.recurring = true
    assert_equal @expense.valid?, true
  end

  def test_that_timestamps_are_created_on_save
    @expense.when = Time.now
    @expense.description = 'Some desc'
    @expense.recurring = false
    @expense.amount = 15.05
    assert_equal @expense.save, true
  end

  def test_that_expenses_scoped_by_recurring
    skip 'todo'
  end

  def test_that_expenses_scoped_by_onceoff
    skip 'todo'
  end
end
