class Api::V1::PostsController < Api::V1::BaseController
  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    Post.transaction do
      @post = Post.create(post_params)
      params[:post][:notifier_ids].each do |notifier_id|
        PostNotifier.create(post_id: @post.id, notifier_id: notifier_id)
      end
    end

    if @post.save
      render json: {status: "SUCCESS", post: @post}
    else
      render json: {status: "FAIL", msg: @post.errors.messages}
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end