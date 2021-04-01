class Reports::CommentsController < CommentsController
  def create
    report = Report.find(params[:report_id])
    comment = report.comments.build(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to report
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
