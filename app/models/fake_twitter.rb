class FakeTwitter
def self.[]=(term, results) #1st argument goes into [], second argument is what you are assigning to it
@data ||= {}
@data[term] = results
end

def self.search(term)
  results = @data[term].map {|hash| Twitter::Status.new(hash.merge(id: 1)) }
  OpenStruct.new(results: results) #OpenStruct makes hashes into methods
end

end
