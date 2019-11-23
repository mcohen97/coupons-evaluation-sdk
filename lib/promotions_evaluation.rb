require "promotions_evaluation/version"
require "./lib/promotions_evaluation/promotions_service.rb"

module PromotionsEvaluation end

class PromotionsEvaluator
  def self.perform_evaluation(url, route, arguments)
    service = PromotionsService.new(url, route)
    service.evaluate(arguments)
  end
end
