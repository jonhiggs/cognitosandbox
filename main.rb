require 'aws-sdk'

require 'json'
creds = JSON.load(File.read('secrets.json'))
Aws.config[:credentials] = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])
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

p auth('erica', 'fish1234')
