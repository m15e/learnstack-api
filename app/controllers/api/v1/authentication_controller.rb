module Api
  module V1
    class AuthenticationController < ApplicationController
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      def create
        if user&.authenticate(params.require(:password))
          token = AuthenticationTokenService.call(user.id)
          render json: { token: token, id: user.id }, status: :created
        else
          render json: { error: 'Wrong Credentials.' }, status:	:unauthorized
        end
      end

      private

      def user
        @user ||= User.find_by(username: params.require(:username))
      end

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end
    end
  end
end
