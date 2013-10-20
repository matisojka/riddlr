module Api
  module V1
    class WebserviceController < ActionController::Base
      protect_from_forgery with: :null_session

      rescue_from EvalBackend::NotAvailable, with: :backend_not_available

      private

      def backend_not_available
        render json: { error: "backend.not_available", message: "Please try again later" },
          status: 504
      end
    end
  end
end
