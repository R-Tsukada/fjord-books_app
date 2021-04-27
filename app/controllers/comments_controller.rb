# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comment.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
