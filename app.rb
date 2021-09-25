# roda applicaiton
require_relative "env"

class App < Roda
  plugin :render, engine: "haml"
  plugin :assets, css: "style.css", js: "app.js"
  plugin :public
  # plugin :static, ["/public"]
  # plugin :request_logger
  # plugin :multi_route
  # plugin :flash
  # plugin :all_verbs
  # plugin :json
  # plugin :partials
  # plugin :error_handler
  
  route do |r|
    r.root do
      view "index"
    end

    r.post("/question") do 
      @question = DavinciCodex.new r.params
      @question.save
      view "question"
    end

    r.public
  end

end
