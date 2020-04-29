class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]
  before_action :require_user
  before_action :require_same_user, except: [:create]

  def create
    @comment = Comment.new(body: params[:comment][:body])
    @comment.creator = current_user
    @comment.ticket_id = params[:ticket_id]

    @comment.save
    redirect_to "/tickets/#{params[:ticket_id]}"
  end

  def edit
    @ticket = Ticket.find(params[:ticket_id])
  end

  def update
    @ticket = Ticket.find(params[:ticket_id])
    @comment.update(body: params[:comment][:body])

    if @comment.save
      flash[:success] = 'Comment updated.'
      redirect_to "/tickets/#{params[:ticket_id]}"
    else
      render :edit
    end
  end

  def destroy
    ticket_id = @comment.ticket_id
    @comment.destroy

    flash['success'] = 'Comment deleted.'
    redirect_to ticket_path(ticket_id)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_same_user
    if current_user != @comment.creator
      flash['danger'] = "You may only edit your own comments."
      redirect_to ticket_path(@comment.ticket_id)
    end
  end
end