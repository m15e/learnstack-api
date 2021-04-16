require 'rails_helper'

describe 'Link API', type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'user', password: 'pass1234') }
  let!(:token) { AuthenticationTokenService.call(user.id) }
  let!(:stack) { FactoryBot.create(:stack, title: 'Learn C++', tags: 'Code C++', user_id: user.id) }

  describe 'POST /links' do
    it 'creates a new link' do
      expect do
        post '/api/v1/links',
             params: { link: { title: 'Rai', url: 'https://a.a.a', medium: 'post', stack_id: stack.id } },
             headers: { 'Authorization' => "Bearer #{token}" }
      end.to change { Link.count }.from(0).to(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /links' do
    let!(:link) { FactoryBot.create(:link, title: 'Rails', url: 'https://a.a.a', medium: 'post', stack_id: stack.id) }

    it 'deletes a link' do
      expect do
        delete "/api/v1/links/#{link.id}",
               headers: { 'Authorization' => "Bearer #{token}" }
      end.to change { Link.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
