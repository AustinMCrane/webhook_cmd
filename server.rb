require 'sinatra'
require 'json'
set :bind, '0.0.0.0'


def get_cmd_for_key(key, passkey)
    file = File.read('./config.json')
    data_hash = JSON.parse(file)
    cmd_pair = data_hash[key]
    unless cmd_pair
        return nil
    end
    if cmd_pair['passkey'] == passkey
        return cmd_pair
    end
    return 'Error'
end

post '/hook' do
    cmd_pair = get_cmd_for_key('test', 'test')
    value = %x(#{cmd_pair['cmd']})
    value
end
