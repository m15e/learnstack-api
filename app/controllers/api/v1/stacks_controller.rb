module Api
  module V1
    class StacksController < ApplicationController
      def index
        stacks = Stack.all
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

      def stack_params
        params.require(:stack).permit(:title, :tags)
      end
    end
  end
end