class GPT3DavinciCodex

  attr_reader :input

  MAX_TOKENS = 70
  STOP_TOKEN = "Q:" # TODO: extract as options

  def initialize(input:)
    @input = input
  end

  def 
    bot_api = OpenAI::Client.new access_token: OPENAI_TOKEN
    puts "Input Text"
    puts input
    puts "---------"
    response = bot_api.completions(
      engine: ENGINE,
      parameters: {
        prompt: input,
        max_tokens: MAX_TOKENS,
        stop: [STOP_TOKEN],
      },
    )
    resp = response.f "choices"
    resp = resp.f 0
    resp = resp.f "text"
    puts "resp: #{resp}"
  end 
end
