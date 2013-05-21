class SearchesController < ApplicationController

def new
end

def create
  search_term = params[:search][:search] #1st form, 2nd field data as string (including pound sign, see below for a fix)
  redirect_to search_path(search_term.gsub(/#/, ''))
end

def show
  @tweets = Searcher.new("##{params[:id]}") #line below moved to searcher.rb model
  # @tweets = Twitter.search("##{params[:id]}").results #:id because it's show action, two pound signs becasue we need the hash, but removed it previously
end

end
