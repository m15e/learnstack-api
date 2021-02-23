class AuthenticationTokenService
  def self.call
    hmac_secret = '$#33kr!t'
    payload = { 'test' => 'wonkywilly' }

    JWT.encode payload, hmac_secret, 'HS256'
  end
end