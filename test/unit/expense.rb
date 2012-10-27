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
    refute_nil @expense.created_at
    refute_nil @expense.updated_at
  end

  def test_that_expenses_scoped_by_recurring_and_onceoff
    @onceoff = Expense.new(
      when: Time.now,
      description: 'Onceoff',
      recurring: false,
      amount: 15.05
    )
    @recurring = Expense.new(
      when: Time.now,
      description: 'Recurring',
      recurring: true,
      amount: 50.51
    )

    assert @onceoff.save
    assert @recurring.save

    onceoff_scope = Expense.onceoff.all
    recurring_scope = Expense.recurring.all

    refute onceoff_scope.sample.recurring
    assert recurring_scope.sample.recurring
  end
end
