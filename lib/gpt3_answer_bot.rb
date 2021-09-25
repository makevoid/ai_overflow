require_relative "../env"

class GPT3AnswerBot
  # ENGINE = "davinci" # text generation / compleition / conversation
  ENGINE = "davinci-codex" # code generation / stackoveflow-like answers / code completion

  attr_reader :question

  # usage: AnswerBot.new(question: "what's the result of `1.+(1)` in ruby?").answer
  # => "A: The result of `1.+(1)` in ruby is 2."

  def initialize(question:)
    @question = question
  end

  def answer
    msg = "
    #{FEW_SHOTS_TEXT}

    # Q: #{question}
    # A:"
    msg = format_msg msg: msg
    answer = openai_complete_code text: msg
    answer
  end

  private

  def openai_complete_code(text:)
    resp = GPT3DavinciCodex.new(input: text).complete
    resp
  end

  def format_msg(msg:)
    lines = msg.split "\n"
    strip_lines lines: lines
  end

  def strip_lines(lines:)
    lines.map do |line|
      line.strip
    end.join "\n"
  end

end

if __FILE__ == $0
  p GPT3AnswerBot.new(question: "what's the result of `1.+(1)` in ruby?").answer
end
