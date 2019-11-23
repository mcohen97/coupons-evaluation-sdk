require "promotions_evaluation/version"
require "./lib/promotions_evaluation/promotions_service.rb"

module PromotionsEvaluation end

class Evaluator
  def self.perform_evaluation(url, route, arguments)
    PromotionsService.instance(url, route).evaluate(arguments)
  end
end
