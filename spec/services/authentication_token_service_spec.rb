require 'rails_helper'

describe AuthenticationTokenService do
  describe '.call' do
    it 'returns an authentication token' do
      hmac_secret = '$#33kr!t'
      token = described_class.call
      decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }

      expect(decoded_token).to eq([
        {"test" => "wonkywilly"}, # payload
        {"alg" => "HS256"} # header
      ])
    end
  end
end