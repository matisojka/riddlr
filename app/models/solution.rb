class Solution < ActiveRecord::Base
  belongs_to :quiz

  validates :quiz, :code, :expectations, presence: true

  before_create :wrap_expectations

  private

  def wrap_expectations
    if self.expectations.is_a?(Array)
      self.expectations = { 'expectations' => self.expectations }
    end
  end
end
