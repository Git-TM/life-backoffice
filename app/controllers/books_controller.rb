require 'open-uri'

class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @books = Book.all
  end

  def search
    @url = "https://www.google.com/search?q=site%3Alifeclub.org+#{params[:book][:title]}&sourceid=chrome&ie=UTF-8"
    html_file = URI.open(@url).open
    @html_doc = Nokogiri::HTML(html_file)
    @array = []
    # @array = @html_doc.search("h3 div")
    @html_doc.search("h3 div").each do |element|
      @array << element.text.strip
    end
  end
end
