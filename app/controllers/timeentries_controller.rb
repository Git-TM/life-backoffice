require "uri"
require "json"
require "net/http"

class TimeentriesController < ApplicationController
  before_action :timeularauthenticate, only: [:subscribe]
  before_action :envload, only: [:subscribe]

  def dashboard
    init
    @timeentries = Timeentry.all
    @allcategorytimes = Categorytime.all
  end

  def subscribe
    url = URI("https://api.timeular.com/api/v3/webhooks/event")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{@token}"
    response = https.request(request)
    @events = response.read_body
  end

  private

  def timeularauthenticate
    url = URI("https://api.timeular.com/api/v3/developer/sign-in")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "apiKey": ENV["TIMEULAR_API_KEY"],
      "apiSecret": ENV["TIMEULAR_API_SECRET"]
    })
    response = https.request(request)
    token_hash = JSON.parse(response.read_body)
    @token = token_hash["token"]
  end

  def envload
    Dotenv::Railtie.load
  end

  def init
    if params[:search].nil?
      @timeall = Timeentry.all
      @sum_jour = 7
    else
      @timeall = Timeentry.where(date: (params[:search][:start_date].to_s..params[:search][:end_date].to_s))
      @sum_jour = params[:search][:end_date].to_date - params[:search][:start_date].to_date
      @allname = Timeentry.pluck(:name).uniq
      # @freelancetag = @timeall.where(name: "Freelance").pluck(:tag).uniq
    end
  end
end
