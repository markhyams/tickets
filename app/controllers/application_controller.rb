class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def projects_empty?
    @projects ||= Project.all 
    @projects.size == 0
  end

  def require_projects
    if projects_empty?
      flash['danger'] ='Please create a project before working on tickets.'
      redirect_to projects_path
    end
  end

  def require_user
    if !logged_in?
      flash['danger'] = 'You must be logged in to do that.'
      redirect_to root_path
    end
  end
end
