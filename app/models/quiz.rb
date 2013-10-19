class Quiz < ActiveRecord::Base
  validates :title, :goal, :expectations, :solution, presence: true

  validates_uniqueness_of :permalink

  before_create :generate_permalink

  def to_param
    self.permalink
  end

  private

  def generate_permalink
    self.permalink =  SecureRandom.hex(12).upcase
  end

end

