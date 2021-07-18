class TasksController < ApplicationController
  before_action :login_required
  before_action :set_user

  def index
    @tasks = @user.tasks
  end

  def create
    @task = Task.create(task_params.merge(user: current_user))
    redirect_to Rails.application.routes.recognize_path(request.referer)
  end

  private

  def task_params
    params.require(:task).permit(:name, :finished)
  end

  def login_required
    redirect_to login_path unless loggend_in?
  end

  def set_user
    @user = (params[:user_id].present? ? User.find(params[:user_id]) : current_user)
  end
end