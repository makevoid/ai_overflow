# monkeypatch alias method f for fetch in both Hash and Array
class Hash
  alias :f :fetch
end

class Array
  alias :f :fetch
end
