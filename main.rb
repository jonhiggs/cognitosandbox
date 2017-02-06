require 'aws-sdk'

require 'json'
creds = JSON.load(File.read('secrets.json'))
Aws.config[:credentials] = Aws::Credentials.new(
  creds['AccessKeyId'],
  creds['SecretAccessKey']
)
Aws.config[:region] = 'us-east-1'

Client = Aws::CognitoIdentityProvider::Client.new

def list_users
    Client.list_users({user_pool_id: "us-east-1_ppS2C0w2h"})
end

def auth(username, password)
    Client.admin_initiate_auth({
        user_pool_id: "us-east-1_ppS2C0w2h",
        client_id: "2c04uaojlrhg1ugcmcapua4etp",
        auth_flow: "ADMIN_NO_SRP_AUTH",
        auth_parameters: {
            "USERNAME": username,
            "PASSWORD": password
        }
    })
end

token = auth('erica', 'fish1234')
#require 'byebug'
#byebug
authentication_result = token.authentication_result.to_hash

access_token = authentication_result[:access_token]
id_token = authentication_result[:id_token]
refresh_token = authentication_result[:refresh_token]

puts "access token:\t#{access_token.size}"
puts "id token:\t#{id_token.size}"
puts "refresh token:\t#{refresh_token.size}"
puts "total size:\t#{access_token.size + id_token.size + refresh_token.size}"




#p token.size
