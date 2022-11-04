class TimewebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :skip_authorization
  # skip_before_action :authenticate_user!

  def create
    request.body.rewind
    response = JSON.parse(request.body.read)
    @webhook = Timewebhook.new(event_data: response)
    @webhook.save!
    # head: ok
  end

  # def provider_timewebhook_params
  #   params.require(:timewebhooks).permit(:event_data)
  # end

  # protected

  # def render_response(status)
  #   render json: { response: "received" }, status: status
  # end

end
