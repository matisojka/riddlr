require 'sandbox'

module Riddlr
  class Evaluator

    attr_reader :code, :expectations

    def initialize(code, expectations, timeout = 5)
      @code = code
      @expectations = expectations
      @timeout = timeout
    end

    def test_run
      sandbox.eval(build_eval_string)
    end

    def run
      result = {}

      begin
        internal_results = sandbox.eval(build_eval_string, timeout: 6)

        result[:passes] = all_passed?(internal_results[:expectations])
        result[:expectations] = internal_results[:expectations]
      rescue Sandbox::SandboxException => e
        if e.message.include?("Timeout::Error")
          result[:passes] = false
          result[:timeout] = 'timeout'
        else
          result[:passes] = false
          result[:error] = {
            message: e.message,
            backtrace: e.backtrace
          }
        end
      end

      result
    end

    private

    def all_passed?(expectations)
      expectations.find { |e| e[:error] }.nil?
    end


    def sandbox
      return @sandbox if @sandbox

      @sandbox = Sandbox::Safe.new
      @sandbox.eval('require "rspec"')
      @sandbox.eval('include RSpec::Matchers')
      @sandbox.eval('require "timeout"')
      @sandbox.activate!

      @sandbox
    end

    public

    def build_eval_string
      eval_string = ["Timeout.timeout(5) do ", "result = {}"]

      eval_string << "return_value = begin"
      eval_string << @code
      eval_string << "end"

      eval_string << "result[:return_value] = return_value"

      eval_string << "result[:expectations] = []"

      @expectations.each do |expecation|
        title = expecation['title']
        _code = expecation['code']

        eval_string << "begin"
        eval_string << _code
        eval_string << "result[:expectations] << {title: '#{title}', passes: true}"

        eval_string << "rescue Exception => e"
        eval_string << "result[:expectations] << { title: '#{title}', error: e.to_s, backtrace: e.backtrace, message: e.message }"
        eval_string << "end"
      end

      eval_string << "result"
      eval_string << "end"

      eval_string.join("\n")
    end

  end

end

