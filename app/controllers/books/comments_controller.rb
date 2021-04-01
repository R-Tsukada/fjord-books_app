class Books::CommentsController < CommentsController
  def create
    book = Book.find(params[:book_id])
    comment = book.comments.build(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to book
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

