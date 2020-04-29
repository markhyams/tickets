class TicketsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :require_projects, except: [:index, :show]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    project_id = params[:project]
    status = params[:status]
    tag = params[:tag]
    tickets = Ticket.all

    if project_id && status
      tickets = tickets.where("project_id = ? ", project_id) if project_id != ""
      tickets = tickets.where("status = ? ", status) if status != ""
      tickets = tickets.joins(:tags_tickets).where(tags_tickets: {tag_id: tag}) if tag != "" 
    end

    @params = params
    @tickets = tickets
  end

  def show
    @comment = Comment.new
  end

  def new
    if Project.all.size == 0
      redirect_to tickets_path
    else
      @ticket = Ticket.new
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    project = Project.find(params[:project_id])
    @ticket.status = params[:status]
    @ticket.creator = current_user
    @ticket.assignee = assignee_from_params(params)
    

    if project.tickets << @ticket
      flash['success'] = 'Ticket created.'
      redirect_to tickets_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @ticket.project_id = params[:project_id]
    @ticket.status = params[:status]
    @ticket.assignee = assignee_from_params(params)

    if @ticket.update(ticket_params)
      flash['success'] = 'Ticket updated.'
      redirect_to ticket_path(@ticket)
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
    query = Ticket.where(id: params[:id])
    if query.first
      @ticket = query.first
    else
      flash['danger'] = 'Ticket could not be found.'
      redirect_to tickets_path
    end
  end

  def ticket_params
    params.require(:ticket).permit(:name, :body, tag_ids: [])
  end

  def assignee_from_params(params)
    assignee = params[:assignee]
    User.where(id: assignee).first
  end
end