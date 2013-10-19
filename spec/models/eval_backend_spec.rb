require 'spec_helper'

describe EvalBackend do
  subject { EvalBackend.new }

  it 'should pass code' do
    e = Expectation.new('It tests stuff', 'expect(1).to be(1)')

    response = subject.eval('', '', [e])

    response.passed?.should be_true
  end

  it 'should fail code' do
    e1 = Expectation.new('It tests that 1 is 1', 'expect(1).to be(1)')
    e2 = Expectation.new('It tests that 1 is 2', 'expect(1).to be(2)')

    response = subject.eval('', '', [e1, e2])

    response.passed?.should be_false

    response.expectations.first.passed?.should be_true

    response.expectations.second.passed?.should be_false
    response.expectations.second.message.should be_present
    response.expectations.second.backtrace.should be_present
  end

  it 'should allow to use local variables' do
    e = Expectation.new('It tests stuff', 'expect(test).to be(1)')

    response = subject.eval('', 'test = 1', [e])

    response.passed?.should be_true
  end

  it 'should report exceptions' do
    response = subject.eval('(', '', [])

    response.error?.should be_true
    response.message.should be_present
    response.backtrace.should be_present
  end

  it 'should timeout', slow: true do
    response = subject.eval('', '1 while true', [])

    response.timeout?.should be_true
  end
end
