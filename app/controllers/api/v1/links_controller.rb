module Api
  module V1
    class LinksController < ApplicationController
      include ActionController::HttpAuthentication::Token      

      before_action :authenticate_user, only: [:create, :destroy]

      def create
        link = Link.new(link_params)

        if link.save
          render json: LinkRepresenter.new(link).as_json, status: :created
        else 
          render json: link.errors, status: :unprocessable_entity
        end        
      end

      def destroy
        link = Link.find(params[:id]).destroy!

        head :no_content
      end

      private

      def authenticate_user
        User.find(get_user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end
      
      def link_params
        params.require(:link).permit(:title, :url, :medium, :stack_id)
      end

      def get_user_id
        # Authorization: Bearer <token>
        token, _options = token_and_options(request)        
        AuthenticationTokenService.decode(token)        
      end
    end
  end
end