module Api
  module V1
    class FavoritesController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: %i[create destroy]

      def index
        favorites = params[:user_id] ? Favorite.where(user_id: params[:user_id]) : []
        render json: FavoritesRepresenter.new(favorites).as_json, status: :ok
      end

      def create
        favorite = Favorite.new(fave_params)
        favorite.user_id = grab_user_id

        if favorite.save
          render json: FavoriteRepresenter.new(favorite).as_json, status: :created
        else
          render json: favorite.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Favorite.where(stack_id: params[:id]).first.destroy!

        head :no_content
      end

      private

      def authenticate_user
        User.find(grab_user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end

      def fave_params
        params.require(:favorite).permit(:stack_id)
      end

      def grab_user_id
        # Authorization: Bearer <token>
        token, _options = token_and_options(request)
        AuthenticationTokenService.decode(token)
      end
    end
  end
end
