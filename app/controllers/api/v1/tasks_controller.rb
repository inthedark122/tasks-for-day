class Api::V1::TasksController < ApiController

  swagger_controller :tasks, 'Task Management'

  swagger_api :index do
    summary 'Get all tasks'
    response :ok
  end

  def index
    @tasks = Task.all
  end

  swagger_api :create do
    summary 'Creates a new Task'
    param :form, 'task[name]', :string, :required, 'Task name'
    param :form, 'task[description]', :string, :required, 'Description about task'
    response :ok
    response :unprocessable_entity
  end

  def create
    @task = Task.new task_params
    unless @task.save
      render json: {errors: [{task: @task.errors}]}, status: :unprocessable_entity
    end
  end

  swagger_api :start do
    summary 'Start the task'
    param :path, :id, :integer, :required, 'Task id'
    response :ok
    response :unprocessable_entity
  end

  def start
    @task = Task.find(params[:id])
    unless @task.update_attribute(:started_at, Time.now)
      render json: {}, status: :unprocessable_entity
    end
  end

  swagger_api :finish do
    summary 'Finish the task'
    param :path, :id, :integer, :required, 'Task id'
    response :ok
    response :unprocessable_entity
  end

  def finish
    @task = Task.find(params[:id])
    if @task.started_at.nil?
      render json: {errors: [{messages: ['Task already finished']}]}, status: :unprocessable_entity
      return false
    end
    @task.finished_at = Time.now
    @task.active_time += (@task.finished_at - @task.started_at).round
    @task.started_at = nil

    if @task.save
      render :start
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  swagger_api :destroy do
    summary 'Delete the task'
    param :path, :id, :integer, :required, 'Task id'
    response :ok
    response :unprocessable_entity
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render json: {}, status: :ok
    else
      render josn: {}, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end