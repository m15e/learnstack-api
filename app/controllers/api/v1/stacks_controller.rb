module Api
  module V1
    class StacksController < ApplicationController
      include ActionController::HttpAuthentication::Token
      FETCH_LIMIT = 25

      before_action :authenticate_user, only: [:create, :destroy]

      def index
        stacks = Stack.limit(limit).offset(params[:offset])
        render json: StacksRepresenter.new(stacks).as_json
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
        stack = Stack.find(params[:id]).destroy!

        head :no_content    
      end

      private

      def authenticate_user
        # Authorization: Bearer <token>
        token, _options = token_and_options(request)        
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
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
    end
  end
end