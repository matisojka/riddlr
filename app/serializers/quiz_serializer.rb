class QuizSerializer < ActiveModel::Serializer
  attributes :title, :description, :goal, :private_environment, :public_environment, :solution,
    :hints, :difficulty, :tags, :author, :private, :expectations, :passes, :permalink, :url

  def passes
    true
  end

  def expectations
    object.expectations[:expectations]
  end

  def url
    quiz_url(object)
  end
end
