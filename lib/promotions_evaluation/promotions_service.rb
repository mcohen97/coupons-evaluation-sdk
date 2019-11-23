require 'faraday'
require 'faraday_middleware'
require_relative './evaluation_response.rb'

class PromotionsService

def initialize(url, route)
  @promotions_server_url = url
  @promotions_server_route = route
  @connection = create_connection
end

def evaluate(body)
  response = post @promotions_server_route, body
  puts "La respuesta es #{response.inspect}"
end

private
  
def create_connection
    
  conn = Faraday.new(url: @promotions_server_url) do |c|
    c.response :logger
    c.request :json
    c.use Faraday::Adapter::NetHttp
  end

  return conn
end

def post(url, payload)

  resp = @connection.post url do |request|
    #request.headers["Authorization"] = authorization
    request.headers['Content-Type'] = 'application/json'
    request.body = payload.to_json
  end
  
  return create_response(resp)

rescue Faraday::Error::ConnectionFailed => e
  return EvaluationResponse.new(success: false, message: e.message)
end

def create_response(resp)
  body = JSON.parse(resp.body)
  successful = resp.status < 300
  if ! successful
    response = EvaluationResponse.new(success: successful, message: body['error_message'])
  else
    response = EvaluationResponse.new(success: successful, message: 'Success!', payload: body)
  end
  return response
end

end