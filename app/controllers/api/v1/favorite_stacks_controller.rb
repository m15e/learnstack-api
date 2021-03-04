module Api
  module V1
    class FavoriteStacksController < ApplicationController
      include ActionController::HttpAuthentication::Token      

      before_action :authenticate_user, only: [:create, :destroy]

      def index
        favorites = Favorite.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded articles', data:favorites},status: :ok
      end

      def create   
        favorite = Favorite.new(fave_params)
        favorite.favorited_type = 'Stack'
        favorite.user_id = get_user_id

        if favorite.save
          render json: FavoriteRepresenter.new(favorite).as_json, status: :created
        else
          render json: favorite.errors, status: :unprocessable_entity
        end
      end

      def destroy
        favorite = Favorite.where(favorited_id: params[:id]).first.destroy!

        head :no_content
      end

      private

      def authenticate_user
        User.find(get_user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end
      
      def fave_params
        params.require(:favorite).permit(:favorited_id) # favorited_id is stack_id
      end


      def get_user_id
        # Authorization: Bearer <token>
        token, _options = token_and_options(request)        
        AuthenticationTokenService.decode(token)        
      end
    end
  end
end