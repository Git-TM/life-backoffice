class Api::V1::TimentriesController < Api::V1::BaseController
  def index
    @timentries = policy_scope(Timentry)
  end
end
