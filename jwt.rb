require 'jwt'

payload = {
  "sub": "e6fb6ed5-55a5-4389-b755-1d6f7823ac2f",
  "aud": "2c04uaojlrhg1ugcmcapua4etp",
  "email_verified": true,
  "token_use": "id",
  "auth_time": 148635102,
  "iss": "https://cognito-idp.us-east-1.amazonaws.com/us-east-1_ppS2C0w2h",
  "cognito:username": "erica",
  "exp": 1486354624,
  "iat": 1486351024,
  "email": "erica.smith@redbubble.com"
}

rsa_private = OpenSSL::PKey::RSA.generate 2048
rsa_public = rsa_private.public_key
token = JWT.encode payload, rsa_private, 'RS256'

# eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJkYXRhIjoidGVzdCJ9.
puts token

# Set password to nil and validation to false otherwise this won't work
decoded_token = JWT.decode token, nil, false

# Array
# [
#   {"data"=>"test"}, # payload
#   {"alg"=>"none"} # header
# ]
puts decoded_token


puts token.size
