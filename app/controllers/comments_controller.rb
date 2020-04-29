class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]
  before_action :set_ticket, except: [:destroy]
  before_action :require_user
  before_action :require_same_user, except: [:create]

  def create
    @comment = Comment.new(body: params[:comment][:body])
    @comment.creator = current_user
    @comment.ticket_id = params[:ticket_id]

    msg = ''

    if @ticket.update(status: params[:status])
      msg += 'Ticket status updated.'
    end

    if @comment.save
      msg += ' Comment created.'
      flash['success'] = msg
      redirect_to ticket_path(@ticket)
    else
      render 'tickets/show'
    end
  end

  def edit
  end

  def update
    @comment.update(body: params[:comment][:body])
    msg = ''

    if @ticket.update(status: params[:status])
      msg += 'Ticket status updated.'
    end

    if @comment.save
      msg += ' Comment updated.'
      flash['success'] = msg
      redirect_to ticket_path(@ticket)
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

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def require_same_user
    if current_user != @comment.creator
      flash['danger'] = "You may only edit your own comments."
      redirect_to ticket_path(@comment.ticket_id)
    end
  end
end