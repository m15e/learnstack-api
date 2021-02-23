class AuthenticationTokenService
  HMAC_SECRET = '$#33kr!t'
  ALGORITHM_TYPE = 'HS256'
  def self.call
    
    payload = { 'test' => 'wonkywilly' }

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end