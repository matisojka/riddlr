module Riddlr
  class Evaluator

    attr_reader :code, :expectations

    def initialize(code, expectations)
      @code = code
      @expectations = expectations
    end

    def run
      sandbox.eval(code, timeout: 2)

      { passes: all_passed?, expectations: checked_expectations }
    rescue Sandbox::SandboxException => e
      { error: e.message }
    end

    private

    def checked_expectations
      @checked_expectations ||= [].tap do |res|
        expectations.each do |exp|
          title = exp['title']
          _code = exp['code']

          begin
            sandbox.eval(_code, timeout: 1)
            res << { title: title, passes: true }
          rescue Sandbox::SandboxException => e
            res << { title: title, error: e.to_s, backtrace: e.backtrace, message: e.message }
          end
        end
      end
    end

    def all_passed?
      checked_expectations.find { |e| e[:error] }.nil?
    end

    def sandbox
      return @sandbox if @sandbox

      @sandbox = Sandbox::Safe.new
      @sandbox.eval('require "rspec"')
      @sandbox.eval('include RSpec::Matchers')
      @sandbox.activate!

      @sandbox
    end

  end

end

