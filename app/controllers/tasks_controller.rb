class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category, only: %i[ index show new edit create update destroy ]
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = @category.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @category.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @category.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to category_task_path(@category.id, @task.id), notice: "Task was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to category_task_path(@category.id, @task.id), notice: "Task was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to category_path(@category.id), notice: "Task was successfully destroyed." }
    end
  end

  def show_tasks_today
    @tasks_today = Task.includes(category: :user).where(user: {id: current_user.id}).where("date_trunc('day',task_date) = current_date")
  end

  private
    def get_category
      @category = Category.find(params[:category_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :body, :task_date, :category_id)
    end
end