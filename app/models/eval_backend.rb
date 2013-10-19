class EvalBackend
  class Response
    attr_reader :response, :expectations

    def initialize(response, expectations)
      @response = response
      @expectations = expectations

      check_timeout || check_error || check_expectations
    end

    def passed?
      response['passes']
    end

    def timeout?
      @timeout
    end

    def error?
      @error
    end

    def message
      @response['error']['message'] if error?
    end

    def backtrace
      @response['error']['backtrace'] if error?
    end

    private

    def check_timeout
      if @response['timeout']
        @timeout = true
      end
    end

    def check_error
      if @response['error']
        @error = true
      end
    end

    def check_expectations
      response['expectations'].each do |exp_hash|
        expectation = expectations.detect{ |e| e.title == exp_hash['title'] }

        if exp_hash['passes']
          expectation.passed!
        else
          expectation.failed(exp_hash['message'], exp_hash['backtrace'])
        end
      end
    end

  end

  attr_reader :hostname, :port

  def initialize(hostname = 'localhost', port = 4567)
    @hostname = hostname
    @port = port
  end

  def eval(environment, user_code, expectations)
    json_content = {
      code: [environment, user_code].join("\n"),
      expectations: convert_expectations(expectations)
    }.to_json

    response_json = JSON.parse(RestClient.post(
      "http://#{hostname}:#{port}/verifications",
      json_content,
      content_type: :json,
      accept: :json
    ))

    Response.new(response_json, expectations)
  end

  private

  def convert_expectations(expectations)
    expectations.map do |expectation|
      {title: expectation.title, code: expectation.code}
    end
  end
end
