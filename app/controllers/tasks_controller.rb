class TasksController < ApplicationController
  before_action :login_required

  def index
    @tasks = Task.all
  end
  def new
    @task = Task.new
  end

  def create
    @task = User.new(task_params)
    render 'new' unless @task.save
  end

  private

  def task_params
    params.require(:task).permit(:name, :account_id, :password, :password_confirmation)
  end

  def login_required
    redirect_to login_path unless loggend_in?
  end
end