require 'rails_helper'

describe 'user API', type: :request do
  

  describe 'POST /users' do
    it 'creates a new user' do
      expect {
          post '/api/v1/users', 
          params: { user: { username: 'user', password: 'passwOrd' } }          
      }.to change { User.count }.from(0).to(1)
      expect(response).to have_http_status(:created)     
    end
  end

  # describe 'DELETE /users' do
  #   let!(:user) { FactoryBot.create(:user, title: 'Learn C++', tags: 'Code C++') }

  #   it 'deletes a user' do
  #     expect {
  #       delete "/api/v1/users/#{user.id}"
  #     }.to change { user.count }.from(1).to(0)

  #     expect(response).to have_http_status(:no_content)
  #   end
  # end
end