require 'rails_helper'

describe 'Stack API', type: :request do
  it 'returns all stacks' do
    FactoryBot.create(:stack, title: 'Learn C++', tags: 'Coding C++')
    FactoryBot.create(:stack, title: 'Learn Ruby', tags: 'Coding Ruby')
    
    get '/api/v1/stacks'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end