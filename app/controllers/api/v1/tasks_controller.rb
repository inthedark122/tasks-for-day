class Api::V1::TasksController < ApiController
  authorize_resource only: [:current]

  swagger_controller :tasks, 'Task Management'

  swagger_api :index do
    summary 'Get all tasks'
    response :ok
  end
  def index
    @tasks = Task.all
  end

  swagger_api :show do |api|
    summary 'Get one task'
    param :path, :id, :integer, :required, 'Task id'
    ApiController::add_common_response(api)
  end
  def show
    @task = Task.find(params[:id])
  end

  swagger_api :current do |api|
    summary 'Get all tasks for current user'
    ApiController::add_common_response(api)
  end
  def current
    @tasks = current_user.tasks
    render :index
  end

  swagger_api :create do |api|
    summary 'Creates a new Task'
    Api::V1::TasksController::add_common_params(api)
    ApiController::add_common_response(api)
  end
  def create
    @task = Task.new task_params
    unless @task.save
      render json: {errors: [@task.errors.to_h]}, status: :unprocessable_entity
    end
  end

  swagger_api :update do |api|
    summary 'Update task'
    param :path, :id, :integer, :required, 'Task id'
    Api::V1::TasksController::add_common_params(api)
    ApiController::add_common_response(api)
  end
  def update
    @task = Task.find(params[:id])
    unless @task.update_attributes task_params
      render json: {errors: [{task: @task.errors}]}, status: :unprocessable_entity
    end
  end

  swagger_api :start do |api|
    summary 'Start the task'
    param :path, :id, :integer, :required, 'Task id'
    ApiController::add_common_response(api)
  end
  def start
    @task = Task.find(params[:id])
    unless @task.update_attribute(:started_at, Time.now)
      render json: {}, status: :unprocessable_entity
    end
  end

  swagger_api :finish do |api|
    summary 'Finish the task'
    param :path, :id, :integer, :required, 'Task id'
    ApiController::add_common_response(api)
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

  swagger_api :destroy do |api|
    summary 'Delete the task'
    param :path, :id, :integer, :required, 'Task id'
    ApiController::add_common_response(api)
  end
  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render json: {}, status: :ok
    else
      render josn: {}, status: :unprocessable_entity
    end
  end

  protected

  def self.add_common_params(api)
    api.param :form, 'task[name]', :string, :required, 'Task name'
    api.param :form, 'task[description]', :string, :required, 'Description about task'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end