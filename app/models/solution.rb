class Solution < ActiveRecord::Base
  belongs_to :quiz

  validates :quiz, :code, :expectations, presence: true

  before_create :wrap_expectations

  def self.fastest_for(quiz)
    self.where(quiz_id: quiz.id).order('time').limit(10)
  end

  def self.smallest_for(quiz)
    self.where(quiz_id: quiz.id).order('code_length').limit(10)
  end

  private

  def wrap_expectations
    if self.expectations.is_a?(Array)
      self.expectations = { 'expectations' => self.expectations }
    end
  end
end
