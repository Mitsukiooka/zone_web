class Api::TasksController < ApplicationController
  skip_forgery_protection
  before_action :authenticate_by_token

  def index
    @tasks = @user.tasks
    render json: @tasks.map { |task| { id: task.id, name: task.name, finished: task.finished } } 
  end

  def create
    @task = Task.create(task_params.merge(user: @user))
    render json: { id: task.id, name: task.name, finished: task.finished }, status: :created
  end

  def update
    task = Task.find(params[:id])
    (task.user == @user) ? task.update(task_params) : render(status: :unauthorized)
  end

  private

  def task_params
    params.require(:task).permit(:name, :finished)
  end

  def authenticate_by_token
    @user = User.find_by(api_token: params[:api_token])
    render status: :unauthorized, json: 'Invalid API token' if @user.blank?
  end

end