require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user, username: 'react-frontend', password: 's3cr3t') }
    let!(:token) { AuthenticationTokenService.call(user.id) }

    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: user.username, password: 's3cr3t' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
                                    'favorites' => [],
                                    'id' => user.id,
                                    'token' => token
                                  })
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 's3cr3t' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
                                    'error' => 'param is missing or the value is empty: username'
                                  })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: user.username }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
                                    'error' => 'param is missing or the value is empty: password'
                                  })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'incorrect' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
