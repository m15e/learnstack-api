module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        p params.require(:password).inspect

        raise AuthenticationError unless user.authenticate(params.require(:password))

        token = AuthenticationTokenService.call(user.id)
        favorites = Favorite.where(user_id: user.id).map(&:stack_id)

        render json: { token: token, id: user.id, favorites: favorites }, status: :created
      end

      private

      def user
        @user ||= User.find_by(username: params.require(:username))
      end

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end
