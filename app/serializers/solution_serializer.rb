class SolutionSerializer < ActiveModel::Serializer
  attributes :quiz_id, :code, :passed, :expectations, :code_length, :time

  def expectations
    object.expectations['expectations']
  end
end
