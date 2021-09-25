class GPT3DavinciCodex

  attr_reader :input

  ENGINE = "davinci-codex" # code generation / stackoveflow-like answers / code completion

  MAX_TOKENS = 60
  STOP_TOKENS = [ # TODO: extract as options
    "\n# Q:",
    "\n#",
    "\n# A:",
  ]

  def initialize(input:)
    @input = input
  end

  def complete
    bot_api = OpenAI::Client.new access_token: OPENAI_TOKEN
    # puts "Input Text"
    # p input
    # puts "---------"
    response = bot_api.completions(
      engine: ENGINE,
      parameters: {
        prompt: input,
        max_tokens: MAX_TOKENS,
        stop: STOP_TOKENS,
      },
    )
    resp = response.body
    resp = JSON.parse resp
    resp = resp.f "choices"
    resp = resp.f 0
    resp = resp.f "text"
    puts "RESP:"
    p resp
    resp
  end
end
