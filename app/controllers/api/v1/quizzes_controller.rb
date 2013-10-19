module Api
  module V1
    class QuizzesController < WebserviceController

      def show
        quiz = Quiz.where(permalink: params[:id]).first

        if quiz
          render json: quiz
        else
          head 404
        end
      end

      def create
        quiz = Quiz.new(quiz_params)
        validator = QuizValidator.new(quiz)
        if validator.call
          if quiz.save
            render json: quiz
          else
            render json: { quiz: {passes: true, errors: quiz.errors } }, status: 422
          end
        else
          render json: validator.response,
            serializer: BackendResponseSerializer,
            root: 'quiz',
            status: 422
        end
      end

      def verification
        quiz = Quiz.where(permalink: params[:id]).first
        validator = QuizValidator.new(quiz, verification_params[:code])

        if quiz
          if validator.call
            solution = Solution.create( quiz: quiz,
                          code: verification_params[:code],
                          passed: validator.response.passed?,
                          expectations: validator.response.expectations)

            render json: solution
          else
            render json: validator.response,
              serializer: BackendResponseSerializer,
              root: 'verification',
              status: 422
          end
        else
          head 404
        end
      end

      private

      def verification_params
        params.require(:verification).permit(:code)
      end

      def quiz_params
        params.require(:quiz).permit(
          :title,
          :description,
          :goal,
          :private_environment,
          :public_environment,
          :solution,
          :hints,
          :difficulty,
          :tags,
          :author,
          :private,
          {expectations: [:title, :code] }
        )
      end
    end
  end
end

