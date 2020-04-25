class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all
  end

  def show

  end

  def new
    @ticket = Ticket.new
    @project_option_tags = Project.option_tags
    @statuses = Ticket::ALLOWED_STATUS
  end

  def create
    @ticket = Ticket.new(ticket_params)
    project = Project.find(params[:project_id])
    @ticket.status = params[:status]
    @project_option_tags = Project.option_tags
    @statuses = Ticket::ALLOWED_STATUS

    if project.tickets << @ticket
      flash['success'] = 'Ticket created.'
      redirect_to tickets_path
    else
      render :new
    end
  end

  def edit
    @project_option_tags = Project.option_tags
    @statuses = Ticket::ALLOWED_STATUS
  end

  def update
    @ticket.project_id = params[:project_id]
    @ticket.status = params[:status]

    if @ticket.update(ticket_params)
      flash['success'] = 'Ticket updated.'
      redirect_to tickets_path
    else
      render :edit
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy

    flash['success'] = 'Ticket deleted.'
    redirect_to tickets_path
  end

  private

  def set_ticket 
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :body)
  end
end