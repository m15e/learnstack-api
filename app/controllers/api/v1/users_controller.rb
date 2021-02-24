module Api
  module V1
    class UsersController < ApplicationController
      def index        
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: { status: 'SUCCESS', message: 'User created', data: user.id }, status: :created
        else
          render json: {status: 'ERROR', message: 'User creation failed :(', data: user.errors}, status: :unprocessable_entity
        end
      end

      def destroy
      end

      private

      def user_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end