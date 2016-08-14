class Text
  def self.send(number, message)
    sender = new(number, message)
    sender.send
  end

  attr_reader :message, :number

  def initialize(number, message)
    @number = "+1#{number}"
    @message = message
  end

  def send
    client.account.messages.create(body)
  end

  private

  def from
    @from ||= ENV['TWILIO_NUMBER']
  end

  def body
    {from: from, to: number, body: message}
  end

  def client
    @client ||= Twilio::REST::Client.new account_sid, auth_token
  end

  def account_sid
    @account_sid ||= ENV["ACCOUNT_SID"]
  end

  def auth_token
    @auth_token ||= ENV["AUTH_TOKEN"]
  end

end
