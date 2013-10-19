class SolutionSerializer < ActiveModel::Serializer
  attributes :quiz_id, :code, :passed, :expectations

  def expectations
    object.expectations['expectations']
  end
end
