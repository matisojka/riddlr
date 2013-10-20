class QuizzesController < ApplicationController

  def new
  end

  def show
  end

  def solutions
    @quiz = Quiz.where(permalink: params[:id]).first
  end

  def random
    redirect_to quiz_path(Quiz.first(order: 'RANDOM()'))
  end

  private

  def angular?
    if params[:action] == 'solutions'
      false
    else
      true
    end
  end

end
