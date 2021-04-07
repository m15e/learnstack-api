module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < ArgumentError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        raise AuthenticationError unless user and user.authenticate(params.require(:password))

        token = AuthenticationTokenService.call(user.id)
        render json: { token: token, id: user.id }, status: :created
      end

      private

      def user
        @user ||= User.find_by(username: params.require(:username))
      end

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated
        render json: { error: 'User not found.' }, status: :not_found
      end
    end
  end
end
