require 'promotions_evaluation'

params = EvaluationParameters.new(country:"ARG", city: "MDZ", birth_date: "05/04/1998", 
  attributes: {total: 200, quantity: 3, products_size: 2}, app_key: "~3zPJ58G501K~TG1y8dri", transaction_id: 8)

res = PromotionsEvaluator.perform_evaluation('pc1', params)

puts res.inspect