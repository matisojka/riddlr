class Quiz < ActiveRecord::Base
  validates :title, :goal, :expectations, :solution, presence: true

  validates_uniqueness_of :permalink

  before_validation :generate_permalink
  after_initialize :wrap_expectations

  has_many :solutions

  scope :public, -> { where(private: nil) }

  scope :latest, -> { public.order('created_at DESC') }

  scope :popular, -> {
    public
      .joins(:solutions)
      .select('quizzes.*, count(solutions.id) as solutions_count')
      .group('quizzes.id')
      .order('solutions_count DESC')
  }

  scope :random, -> { public.order("RANDOM()") }

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

