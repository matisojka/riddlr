class SolutionSerializer < ActiveModel::Serializer
  attributes :quiz_id, :code, :passed, :expectations, :code_length, :time, :url

  def expectations
    object.expectations['expectations']
  end

  def url
    solution_url(object)
  end

end
