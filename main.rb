require 'aws-sdk'

require 'json'
creds = JSON.load(File.read('secrets.json'))
Aws.config[:credentials] = Aws::Credentials.new(
  creds['AccessKeyId'],
  creds['SecretAccessKey']
)
Aws.config[:region] = 'us-east-1'

CLIENT_ID = "2c04uaojlrhg1ugcmcapua4etp"
Client = Aws::CognitoIdentityProvider::Client.new

def list_users
    Client.list_users({user_pool_id: "us-east-1_ppS2C0w2h"})
end

def sign_up(email,password,field_size=1)
  data = {
    client_id: CLIENT_ID,
    username: email,
    password: password,
    user_attributes: [
      {
        name: 'email',
        value: email
      },
      {
        name: 'custom:data_01',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_02',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_03',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_04',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_05',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_06',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_07',
        value: random_string(field_size)
      },
      {
        name: 'custom:data_08',
        value: random_string(248)
      },
    ]
  }

  puts "signing up with #{data.to_s.size} chars of data"
  Client.sign_up(data)
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

def confirm_signup(email)
  Client.admin_confirm_sign_up({
    user_pool_id: "us-east-1_ppS2C0w2h",
    username: email
  })

end

def random_string(size)
  (0...size).map { ('a'..'z').to_a[rand(26)] }.join
end

email = "#{random_string(249-128)}@rb.com"
password = random_string(256)
n = 255
puts "signing up user '#{email}' with #{n} chars of data."
sign_up(email, password, n)
confirm_signup(email)

token = auth(email, password)
authentication_result = token.authentication_result.to_hash
id_token = authentication_result[:id_token]
puts "id token:\t#{id_token.size}"
