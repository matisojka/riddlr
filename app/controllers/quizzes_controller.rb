class QuizzesController < ApplicationController

  def new
  end

  def show
  end

  def random
    redirect_to quiz_path(Quiz.first(order: 'RANDOM()'))
  end

end
