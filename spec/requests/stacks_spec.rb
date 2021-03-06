require 'rails_helper'

describe 'Stack API', type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'user', password: 'pass1234') }  
  let!(:token) { AuthenticationTokenService.call(user.id) }

  describe 'GET /stacks' do
    before do      
      p user.id
      FactoryBot.create(:stack, title: 'Learn C++', tags: 'Code C++', user_id: user.id)
      FactoryBot.create(:stack, title: 'Learn Ruby', tags: 'Code Ruby', user_id: user.id)
    end

    it 'returns all stacks' do

      get '/api/v1/stacks'

      expect(response).to have_http_status(:success)      
    end

    it 'returns the correct number of stacks' do
      
      get '/api/v1/stacks'

      expect(response_body.size).to eq(2)
    end

    it 'returns a subset of books based on limit' do
      get '/api/v1/stacks', params: { limit: 1 }
      expect(response_body.size).to eq(1)
    end

    it 'returns a subset of books based on limit and offset' do
      get '/api/v1/stacks', params: { limit: 1, offset: 1 }
      expect(response_body.size).to eq(1)
    end

    it 'has a max limit of 25' do      
      expect(Stack).to receive(:limit).with(25).and_call_original

      get '/api/v1/stacks', params: { limit: 100 }      
    end
  end

  describe 'POST /stacks' do
    it 'creates a new stack' do
      expect {
          post '/api/v1/stacks', 
          params: { stack: { title: 'Learn Lavarel', tags: 'Code Lavarel', user_id: user.id } }, 
          headers: { "Authorization" => "Bearer #{token}" }
      }.to change { Stack.count }.from(0).to(1)
      expect(response).to have_http_status(:created)     
    end
  end

  describe 'DELETE /stacks' do
    let!(:stack) { FactoryBot.create(:stack, title: 'Learn C++', tags: 'Code C++', user_id: user.id) }    

    it 'deletes a stack' do
      expect {
        delete "/api/v1/stacks/#{stack.id}",
        headers: { "Authorization" => "Bearer #{token}" } 
      }.to change { Stack.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end