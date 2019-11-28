require 'faraday'
require 'faraday_middleware'
require_relative './evaluation_response.rb'

class PromotionsService

PROMOTIONS_SERVER_URL = 'https://coupons-gateway.herokuapp.com'
PROMOTIONS_SERVER_ROUTE_1 = '/v1/promotions/'
PROMOTIONS_SERVER_ROUTE_2 = '/evaluate'
SERVER_ERROR_MESAGE_KEY = 'error'


def self.instance
  @instance = @instance || PromotionsService.new()
  return @instance
end

def evaluate(promo_code, body)
  route = PROMOTIONS_SERVER_ROUTE_1 + promo_code + PROMOTIONS_SERVER_ROUTE_2
  response = post route, body.generate_request_body()
end

private

def initialize()
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
    response = EvaluationResponse.new(success: successful, message: body[SERVER_ERROR_MESAGE_KEY])
  else
    response = EvaluationResponse.new(success: successful, message: 'Success!', payload: body)
  end
  return response
end

end