require "promotions_evaluation/version"
require "./lib/promotions_evaluation/promotions_service.rb"

module PromotionsEvaluation end

class PromotionsEvaluator
  def self.perform_evaluation(promotion_code, evaluation_args)
    return PromotionsService.instance.evaluate(promotion_code, evaluation_args)
  end
end

class EvaluationParameters
  
  def initialize(args)
    @app_key = args[:app_key]
    @coupon_code = args[:coupon_code]
    @user_id = args[:user_id]
    @attributes = args[:attributes]
    @country = args[:country]
    @city = args[:city]
    @birth_date = args[:birth_date]
    @transaction_id = args[:transaction_id]
  end

  def generate_request_body()

    base_body = {
            token: @app_key,
            attributes: @attributes,
            demography: {
              country: @country,
              city: @city,
              birth_date: @birth_date
            }
    }

    if !@transaction_id.nil?
      base_body[:transaction_id] = @transaction_id
    else
     base_body[:coupon_code] = @coupon_code,
     base_body[:user] = @user_id
    end

    puts "BODY: #{base_body.inspect}"
    return base_body
  end
end
