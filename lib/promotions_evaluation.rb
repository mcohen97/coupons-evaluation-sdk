require "promotions_evaluation/version"
require "./lib/promotions_evaluation/promotions_service.rb"

module PromotionsEvaluation
  class Evaluator
    def self.perform_evaluation(arguments)
      PromotionsService.instance.evaluate(arguments)
    end
  end
end
