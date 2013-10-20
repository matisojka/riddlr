module Api
  module V1
    class VerificationsController < WebserviceController
      def create
        backend_response = eval_backend.eval(*convert_params)

        render json: backend_response,
          status: http_code_for(backend_response),
          serializer: BackendResponseSerializer,
          root: 'verification'
      end

      private

      def convert_params
        verification_params = params[:verification]

        expectations = verification_params[:expectations].map do |expectation|
          Expectation.from_hash(expectation)
        end

        private_env = verification_params[:private_environment]
        public_env = verification_params[:public_environment]
        solution = verification_params[:solution]

        [solution, [private_env, public_env].join("\n"), expectations]
      end

      def eval_backend
        @backend ||= EvalBackend.new
      end

      def http_code_for(backend_response)
        if backend_response.timeout?
          422
        elsif backend_response.error?
          422
        elsif !backend_response.passed?
          422
        else
          200
        end
      end
    end
  end
end
