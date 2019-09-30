class Api::V1::RecommendController < Api::V1::BaseController

  def suggest
    key = "#{RecommendService::PREFIX_KEY}#{params[:user_id]}"
    user_ids = JSON.parse($redis.get(key) || "[]")
    @users = User.find(user_ids)
    render json: {users: @users}
  end
end