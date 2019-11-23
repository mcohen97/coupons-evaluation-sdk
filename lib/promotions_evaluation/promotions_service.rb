require 'faraday'
require 'faraday_middleware'
require_relative './evaluation_response.rb'

class PromotionsService

PROMOTIONS_SERVER_URL = 'http://localhost:3000'

PROMOTIONS_SERVER_ROUTE = '/promotions/evaluate'

def self.instance()
  @instace || PromotionsService.new()
end

def evaluate(body)
  response = post PROMOTIONS_SERVER_ROUTE, body
  puts "La respuesta es #{response.inspect}"
end


private

def initialize
  @connection = create_connection
end
  
def create_connection
    
  conn = Faraday.new(url: PROMOTIONS_SERVER_URL) do |c|
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
    response = EvaluationResponse.new(success: success, message: body['error_message'])
  else
    response = EvaluationResponse.new(success: success, message: 'Success!', payload: body)
  end
  return response
end

end