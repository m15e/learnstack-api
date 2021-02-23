module Api
  module V1
    class StacksController < ApplicationController
      FETCH_LIMIT = 25

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

      def limit
        [
          params.fetch(:limit, FETCH_LIMIT).to_i, 
          FETCH_LIMIT
        ].min
      end

      def stack_params
        params.require(:stack).permit(:title, :tags)
      end
    end
  end
end