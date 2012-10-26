class Expense
  include MongoMapper::Document

  key :when, Time
  key :description, String
  key :recurring, Boolean, :required => true
  key :amount, Float, :required => true

  timestamps!

  belongs_to :user

  scope :recurring, where(:recurring => true)
  scope :onceoff, where(:recurring => false)
end
