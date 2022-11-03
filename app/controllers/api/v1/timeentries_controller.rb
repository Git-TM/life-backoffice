module Api
  class Api::V1::TimeentriesController < Api::V1::BaseController
    def index
      @timeentries = policy_scope(Timeentry)
      render json: @timeentries, status: 200
    end

    def create
      @timeentry = Timeentry.new(timeentry_params)
      authorize @timeentry
      if @timeentry.save
        render :show, status: :created
      else
        render_error
      end
    end
  end
end
