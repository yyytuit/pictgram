class CommentsController < ApplicationController
  def index
  end

  def new
    if logged_in?
      @comment = Comment.new(user_id: current_user.id,topic_id: params[:topic_id])
    else
      redirect_to topics_path
    end
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to topics_path, success: 'コメントしました'
    else
      flash.now[:danger] = "コメントできませんでした"
      render :new
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to topics_path, success: 'コメントを編集しました'
    else
      flash.now[:danger] = "コメントを編集できませんでした"
      render :edit
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment .destroy
    redirect_to topics_path, success: 'コメントを削除しました'
  end

  private
  def comment_params
    params.require(:comment).permit(:detail, :topic_id)
  end
end
