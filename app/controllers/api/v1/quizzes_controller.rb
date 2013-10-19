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
            render json: { quiz: {passes: true, errors: quiz.errors } }
          end
        else
          render json: validator.response, serializer: BackendResponseSerializer, root: 'quiz'
        end
      end

      private


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

