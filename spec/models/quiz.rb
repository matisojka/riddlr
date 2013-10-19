require 'spec_helper'

describe Quiz do
  let(:valid_attributes) do
    {
      title: 'Test',
      goal: 'This is just a test',
      expectations: {expectations: [{title: 'Test this', code: 'expect(1).to eq(1)' }] },
      solution: '# Ha I win'
    }
  end

  describe '#permalink' do
    it 'should generate permalink on create' do
      quiz = Quiz.create(valid_attributes)

      quiz.should be_persisted
      quiz.permalink.should be_present
    end
  end
end
