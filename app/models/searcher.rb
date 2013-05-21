class Searcher

class_attribute :backend #allows to set it on class and instance level
self.backend = Twitter

def initialize(term)
  @term = term
end

def each(&block)
  backend.search(@term).results.each(&block)
end

end
