class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
    if params[:sort_expired] == 'true'
      @tasks = Task.all.order(deadline: :desc)
    end
    if params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
    end
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if params[:task].present? && params[:task][:status].present?
        @tasks = Task.search_title(title).search_status(status)
      elsif params[:task].present?
        @tasks = Task.search_title(title)
      elsif params[:status].present?
        @tasks = Task.search_status(status)
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, :page)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
