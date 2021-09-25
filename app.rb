# roda applicaiton
require_relative "env"

class NullQuestion; def body; end; end

class App < Roda
  plugin :render, engine: "haml"
  plugin :assets, css: "style.css", js: "app.js"
  plugin :public
  plugin :all_verbs
  plugin :json
  plugin :error_handler
  plugin :common_logger
  
  route do |r|
    r.root do
      question = NullQuestion.new
      view "index", locals: { question: question }
    end

    r.on "question" do
      r.post do
        question = DavinciCodex.new r.params
        view "question", locals: { question: question }
      end

      r.get do 
        "not implemented"
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
