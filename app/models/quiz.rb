class Quiz < ActiveRecord::Base

  validates :title, :goal, :expectations, :solution, presence: true

end

