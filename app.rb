# roda applicaiton
require_relative "env"

# model

class NullQuestion; def question; end; def answer; end; end

class Question
  attr_reader :question, :answer, :answer_orig

  def initialize(question:, answer:)
    @question = question
    @answer_orig = answer
    @answer = trim_answer answer: answer
  end

  def trim_answer(answer:)
    # trim string the sring answer, remove every char after the last " , "
    answer.gsub /(\s,\s)*$/, ""
    # TODO: find a better method
    # answer.gsub /[^\p{Punct}]*$/, ""
  end
end

# utils

ExtractQuestion = -> (question:) {
  question.strip!
  # TODO: refactor
  question = "#{question} ?" unless question[-1] == "?"
  puts "QUESTION"
  p question
  # limit question to 100 chars
  question[0..99]
}
# controller (app)

class App < Roda
  plugin :render, engine: "haml"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger
  # plugin :assets, css: "style.css", js: "app.js"

  route do |r|
    r.root do
      question = NullQuestion.new
      view "index", locals: { question: question }
    end

    r.on "questions" do
      r.post do
        question = r.params["question"]
        question = ExtractQuestion.(question: question)
        bot = GPT3AnswerBot.new question: question
        answer = bot.answer
        question = Question.new question: question, answer: answer
        view "index", locals: { question: question }
      end

      r.get do
        r.redirect "/"
      end
    end

    # TODO: add redis

    r.on "few-shots-add" do
      r.post do
        question = r.params["question"]
        answer = r.params["answer"]
        question = FewShotsAdd.new question: question, answer: answer
        view "question-added", locals: { question: question, answer: answer }
      end
    end

    r.on "text" do
      r.get "few-shots" do
        File.read "./public/text/few-shots.txt"
      end

      r.get "training-data" do
        File.read "./public/text/training-data.txt"
      end
    end

    r.public
  end
end
