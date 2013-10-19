class QuizValidator < ActiveModel::Serializer
  attr_reader :quiz, :user_code

  def initialize(quiz, user_code = nil)
    @quiz = quiz
    @user_code = user_code || quiz.solution
  end

  def call
    if quiz.solution.present? && quiz.expectations.present?
      response.passed?
    else
      false
    end
  end

  def response
    @response ||= backend.eval(quiz.private_environment, user_code, expectations)
  end

  private

  def expectations
    quiz.expectations['expectations'].map do |expectation|
      Expectation.from_hash(expectation)
    end
  end

  def backend
    @backend ||= EvalBackend.new
  end
end
