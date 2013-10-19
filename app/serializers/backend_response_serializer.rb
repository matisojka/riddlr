class BackendResponseSerializer < ActiveModel::Serializer
  attribute :passes

  def passes
    !!object.passed?
  end

  def attributes
    hash = super

    if object.timeout?
      hash[:timeout] = true
    elsif object.error?
      hash[:error] = true
      hash[:message] = object.message
      hash[:backtrace] = object.backtrace
    else
      hash[:expectations] = expectations
    end

    hash
  end

  private

  def expectations
    object.expectations.map do |expectation|
      if expectation.passed?
        { title: expectation.title, passed: true}
      else
        {
          title: expectation.title,
          passed: false,
          message: expectation.message,
          backtrace: expectation.backtrace
        }
      end
    end
  end
end
