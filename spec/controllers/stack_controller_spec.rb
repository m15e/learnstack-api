require 'rails_helper'

RSpec.describe Api::V1::StacksController, type: :controller do
  it 'has a max limit of 25' do
    expect(Stack).to receive(:limit).with(25).and_call_original

    get :index, params: { limit: 100 }
  end
end
