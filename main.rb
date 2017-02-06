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

def sign_up(email,password,field_size=1)
  data = (0...field_size).map { ('a'..'z').to_a[rand(26)] }.join
  Client.sign_up({
    client_id: CLIENT_ID,
    username: email,
    password: password,
    user_attributes: [
      {
        name: 'email',
        value: email
      },
      {
        name: 'data_01',
        value: data
      },
      {
        name: 'data_02',
        value: data
      },
      {
        name: 'data_03',
        value: data
      },
      {
        name: 'data_04',
        value: data
      },
      {
        name: 'data_05',
        value: data
      },
      {
        name: 'data_06',
        value: data
      },
      {
        name: 'data_07',
        value: data
      },
    ]
  })
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
random_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
email = "#{random_string}@rb.com"
password = random_string
sign_up(email, password, 1)

puts "signing up user '#{email}'."

authentication_result = token.authentication_result.to_hash

id_token = authentication_result[:id_token]
puts "id token:\t#{id_token.size}"
