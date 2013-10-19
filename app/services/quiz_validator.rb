class QuizValidator
  attr_reader :quiz

  def initialize(quiz)
    @quiz = quiz
  end

  def call
    if quiz.solution.present? && quiz.expectations.present?
      response.passed?
    else
      false
    end
  end

  def response
    @response ||= backend.eval(quiz.private_environment, quiz.solution, expectations)
  end

  private

  def expectations
    quiz.expectations.map do |expectation|
      Expectation.from_hash(expectation)
    end
  end

  def backend
    @backend ||= EvalBackend.new
  end
end
