class Quiz < ActiveRecord::Base
  validates :title, :goal, :expectations, :solution, presence: true

  validates_uniqueness_of :permalink

  before_validation :generate_permalink
  after_initialize :wrap_expectations

  def to_param
    self.permalink
  end

  private

  def generate_permalink
    self.permalink = SecureRandom.hex(12).upcase
  end

  def wrap_expectations
    if self.expectations.is_a?(Array)
      self.expectations = {'expectations' => self.expectations}
    end
  end

end

