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
    link = element.attribute("href").value
    @html_doc.search("div > a").each do |element|
      element.attribute("href").value.include?("https://lifeclub.org") && @array << link
    end
  end
end
