class EvaluationResponse

  attr_reader :success, :message, :payload

  def initialize(arguments)
    @successful = arguments[:success]
    @message = arguments[:message]
    @payload = arguments[:payload]
  end

end