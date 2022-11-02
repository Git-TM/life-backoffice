class Api::V1::TimeentriesController < Api::V1::BaseController
  def index
    @timeentries = policy_scope(Timeentry)
    render json: @timeentries, status: 200
  end
  def create
    # binding.pry
  end
end
