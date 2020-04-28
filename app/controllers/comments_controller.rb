class CommentsController < ApplicationController
  def create
    @comment = Comment.new(body: params[:comment][:body])
    @comment.creator = current_user
    @comment.ticket_id = params[:ticket_id]

    @comment.save
    redirect_to "/tickets/#{params[:ticket_id]}"
  end

  def edit
    @comment = Comment.find(params[:id])
    @ticket = Ticket.find(params[:ticket_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(body: params[:comment][:body])

    @comment.save

    redirect_to "/tickets/#{params[:ticket_id]}"
  end

  def destroy

  end
end