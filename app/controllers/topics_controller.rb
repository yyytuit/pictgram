class TopicsController < ApplicationController
  def index
    @topics = Topic.all.includes(:favorite_users)
    @favorite_topics = current_user.favorite_topics.count
  end

  def new
    if logged_in?
      @topic = Topic.new
    else
      redirect_to topics_path
    end
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  private
  def topic_params
    puts '####params#####'
    puts params
    puts '####params#####'
    params.require(:topic).permit(:image, :description)
  end
end
