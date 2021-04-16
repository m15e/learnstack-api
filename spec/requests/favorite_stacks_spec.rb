require 'rails_helper'

describe 'Favorite_stack API', type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'user', password: 'pass1234') }
  let!(:token) { AuthenticationTokenService.call(user.id) }
  let!(:stack) { FactoryBot.create(:stack, title: 'Learn C++', tags: 'Code C++', user_id: user.id) }

  describe 'POST /favorite_stacks' do
    it 'creates a new favorite' do
      expect do
        post '/api/v1/favorite_stacks',
             params: { favorite: { user_id: user.id, favorited_id: stack.id } },
             headers: { 'Authorization' => "Bearer #{token}" }
      end.to change { Favorite.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /favorite_stacks' do
    let!(:favorite) { FactoryBot.create(:favorite, user_id: user.id, favorited_id: stack.id) }

    it 'deletes a favorite' do
      expect do
        delete "/api/v1/favorite_stacks/#{stack.id}",
               headers: { 'Authorization' => "Bearer #{token}" }
      end.to change { Favorite.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
