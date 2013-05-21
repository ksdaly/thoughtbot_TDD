class FakeTwitter
def self.[]=(term, results) #1st argument goes into [], second argument is what you are assigning to it
@data ||= {}
@data[term] = results
end

def self.search(term)
  results = @data.fetch(term, []).map do |hash|
  hash_with_id = hash.merge(id: 1)
  Twitter::Status.new(hash_with_id)
  end
  OpenStruct.new(results: results) #OpenStruct makes hashes into methods
end

def self.clear
  @data = {}
end


end
