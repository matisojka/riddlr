class SolutionsController < ApplicationController

  before_action :get_solution
  before_action :is_users_solution
  after_action :remove_users_solution

  def show
    @users_solution = session[:users_solution].present?
  end


  private

  def get_solution
    @solution = Solution.find(params[:id])
  end

  def is_users_solution
    if params[:users_solution]
      session[:users_solution] = true
      redirect_to solution_path(@solution)
    end
  end

  def remove_users_solution
    session.delete(:users_solution)
  end

  def angular?
    false
  end
  helper_method :angular?

end
