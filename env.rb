# require bundler
require "bundler/setup"
Bundler.require :default

PATH = File.expand_path "../", __FILE__

require_relative "env_secret"

def load_few_shots_text
  text = File.read "#{PATH}/few_shots_learning_text.txt"
  text.strip
end

FEW_SHOTS_TEXT = load_few_shots_text

OPENAI_TOKEN
