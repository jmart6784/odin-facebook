class LikesController < ApplicationController
  def index_likes_update
    @post = Post.find(params[:id])
    like = Like.where(post_id: @post.id, user_id: current_user.id)

    if like == []
      @post.likes.create!(user_id: current_user.id, post_id: @post.id)
    else
      like.destroy_all
    end

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end