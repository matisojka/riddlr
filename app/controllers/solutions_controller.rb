class SolutionsController < ApplicationController
  def show
    @solution = Solution.find(params[:id])
  end


  private

  def angular?
    false
  end
  helper_method :angular?
end
