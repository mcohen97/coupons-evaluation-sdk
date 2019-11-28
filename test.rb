require 'promotions_evaluation'

params = EvaluationParameters.new(country:"ARG", city: "MDZ", birth_date: "05/04/1998", 
  attributes: {total: 200, quantity: 3, products_size: 2}, app_key: "OihZ0CF87pKKxzHHa0dPy", transaction_id: 16708928)

res = PromotionsEvaluator.perform_evaluation('pc1826', params)

puts res.inspect