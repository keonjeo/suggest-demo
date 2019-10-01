class RecommendService

  PREFIX_KEY = "suggest-"
  SUGGEST_STRONG_WEIGHT = 100
  SUGGEST_WEAK_WEIGHT = 1

  def initialize(user_id)
    @user_id = user_id
    @result = {}
  end

  def run
    post_ids = PostNotifier.where(notifier_id: @user_id).pluck(:post_id)
    caculate(post_ids, SUGGEST_STRONG_WEIGHT, [@user_id])

    user_ids = Post.where(id: post_ids).pluck(:user_id)
    other_post_ids = Post.where(user_id: user_ids).pluck(:id) - post_ids

    caculate(other_post_ids, SUGGEST_WEAK_WEIGHT, user_ids)

    @result = @result.sort_by { |_, v| v }.reverse.to_h
    value = @result.map {|k,v|k}

    $redis.set("#{PREFIX_KEY}#{@user_id}", value.to_json)
  end

  private

  def caculate(post_ids, weight, itself)
    user_ids = PostNotifier.where(post_id: post_ids).pluck(:notifier_id)
    user_ids.each do |user_id|
      next if itself.include?(user_id)
      @result[user_id] = @result[user_id].to_i + weight
    end
  end
end