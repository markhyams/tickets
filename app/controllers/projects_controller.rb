class ProjectsController < ApplicationController
  before_action :require_user, except: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash['success'] = 'Project created.'
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project.update(project_params)

    if @project.save
      flash['success'] = 'Project updated.'
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash['primary'] = 'Project deleted.'
    redirect_to projects_path
  end

  private

  def set_project
    query = Project.where(id: params[:id])
    if query.first
      @project = query.first
    else
      flash['danger'] = 'Project could not be found.'
      redirect_to projects_path
    end
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
