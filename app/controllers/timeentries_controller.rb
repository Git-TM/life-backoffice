require "uri"
require "json"
require "net/http"

class TimeentriesController < ApplicationController
  before_action :envload, only: [:timeularauthenticate]
  before_action :timeularauthenticate, only: [:dashboard, :listwebhooks, :subscribewebhooks]
  before_action :listwebhooks, only: [:dashboard]
  # before_action :subscribewebhooks, only: [:dashboard]
  # before_action :init, only: [:dashboard]

  def dashboard
    init
    @timeentries = Timeentry.all
    @allcategorytimes = Categorytime.all
  end

  def listwebhooks
    url = URI("https://api.timeular.com/api/v3/webhooks/subscription")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{@token}"
    response = https.request(request)
    @env_key = ENV['TIMEULAR_API_KEY']
    @json_subscription = JSON.parse(response.read_body)
    if @json_subscription["subscriptions"].empty?
      subscribewebhooks
    end
  end

  def subscribewebhooks
    url = URI("https://api.timeular.com/api/v3/webhooks/subscription")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{@token}"
    request.body = "{\n    \"event\": \"trackingCreated\",\n    \"target_url\": \"https://www.tristan-bo/timewebhooks\"\n}"
    response = https.request(request)
    @webhook_response = response.read_body
  end

  def timeularauthenticate
    url = URI("https://api.timeular.com/api/v3/developer/sign-in")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "apiKey": ENV['TIMEULAR_API_KEY'],
      "apiSecret": ENV['TIMEULAR_API_SECRET']
    })
    @response = https.request(request)
    @token_response = @response.read_body
    @token_hash = JSON.parse(@response.read_body)
    @token = @token_hash["token"]
  end

  def create
  end

  private


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
    end
  end
end
