module Api
  module V1
    class StacksController < ApplicationController
      include ActionController::HttpAuthentication::Token
      FETCH_LIMIT = 25

      before_action :authenticate_user, only: %i[create destroy]

      def index
        stacks = Stack.all
        render json: StacksRepresenter.new(stacks).as_json
      end

      def show
        stack = Stack.find(params[:id])
        render json: StackRepresenter.new(stack).as_json
      end

      def create
        stack = Stack.new(stack_params)

        if stack.save
          render json: StackRepresenter.new(stack).as_json, status: :created
        else
          render json: stack.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Stack.find(params[:id]).destroy!

        head :no_content
      end

      private

      def authenticate_user
        User.find(grab_user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end

      def limit
        [
          params.fetch(:limit, FETCH_LIMIT).to_i,
          FETCH_LIMIT
        ].min
      end

      def stack_params
        params.require(:stack).permit(:title, :tags, :user_id)
      end

      def grab_user_id
        token, _options = token_and_options(request)
        AuthenticationTokenService.decode(token)
      end
    end
  end
end
