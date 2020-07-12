class LikesController < ApplicationController

  def like
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: @post.id)
    like.save


  end

  def unlike
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    #like.destroy
    Like.delete_all(post_id: @post.id, user_id: current_user)

  end
end
