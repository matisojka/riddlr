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
        result[:total_time] = internal_results[:total_time]
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
      @sandbox.eval('require "benchmark"')
      @sandbox.eval("require 'rspec/matchers/built_in/be_instance_of'")
      @sandbox.eval("require 'rspec/matchers/built_in/be'")
      @sandbox.eval("require 'rspec/matchers/built_in/be'")
      @sandbox.eval("require 'rspec/matchers/built_in/be'")
      @sandbox.eval("require 'rspec/matchers/built_in/be'")
      @sandbox.eval("require 'rspec/matchers/built_in/be'")
      @sandbox.eval("require 'rspec/matchers/built_in/be'")
      @sandbox.eval("require 'rspec/matchers/built_in/be_kind_of'")
      @sandbox.eval("require 'rspec/matchers/built_in/be_within'")
      @sandbox.eval("require 'rspec/matchers/built_in/change'")
      @sandbox.eval("require 'rspec/matchers/built_in/cover' if (1..2).respond_to?(:cover?)")
      @sandbox.eval("require 'rspec/matchers/built_in/eq'")
      @sandbox.eval("require 'rspec/matchers/built_in/eql'")
      @sandbox.eval("require 'rspec/matchers/built_in/equal'")
      @sandbox.eval("require 'rspec/matchers/built_in/exist'")
      @sandbox.eval("require 'rspec/matchers/built_in/has'")
      @sandbox.eval("require 'rspec/matchers/built_in/have'")
      @sandbox.eval("require 'rspec/matchers/built_in/include'")
      @sandbox.eval("require 'rspec/matchers/built_in/match'")
      @sandbox.eval("require 'rspec/matchers/built_in/match_array'")
      @sandbox.eval("require 'rspec/matchers/built_in/raise_error'")
      @sandbox.eval("require 'rspec/matchers/built_in/respond_to'")
      @sandbox.eval("require 'rspec/matchers/built_in/start_and_end_with'")
      @sandbox.eval("require 'rspec/matchers/built_in/start_and_end_with'")
      @sandbox.eval("require 'rspec/matchers/built_in/satisfy'")
      @sandbox.eval("require 'rspec/matchers/built_in/throw_symbol'")
      @sandbox.eval("require 'rspec/matchers/built_in/yield'")
      @sandbox.eval("require 'rspec/matchers/built_in/yield'")
      @sandbox.eval("require 'rspec/matchers/built_in/yield'")
      @sandbox.eval("require 'rspec/matchers/built_in/yield'")
      @sandbox.activate!

      @sandbox
    end

    public

    def build_eval_string
      eval_string = ["Timeout.timeout(5) do ", "result = {}"]
      eval_string << "bench_res = Benchmark.measure do"
      eval_string << "return_value = nil"
      eval_string << "return_value = begin"
      eval_string << @code
      eval_string << "end"

      eval_string << "result[:return_value] = return_value"

      eval_string << "result[:expectations] = []"

      @expectations.each do |expecation|
        title = expecation['title'].gsub('"', "\\\"")
        _code = expecation['code']

        eval_string << "begin"
        eval_string << _code
        eval_string << %|result[:expectations] << {title: "#{title}", passes: true}|

        eval_string << "rescue Exception => e"
        eval_string << %|result[:expectations] << { title: "#{title}", error: e.to_s, backtrace: e.backtrace, message: e.message }|
        eval_string << "end"
      end

      eval_string << "end"
      eval_string << "result[:total_time] = bench_res.total"

      eval_string << "result"
      eval_string << "end"

      eval_string.join("\n")
    end

  end

end

