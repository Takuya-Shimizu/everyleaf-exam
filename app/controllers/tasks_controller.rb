class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :own_task, only: %i[ show edit update destroy ]

  def index
    @tasks = current_user.tasks.all
    if params[:sort_expired] == 'true'
      @tasks = current_user.tasks.all.order(deadline: :desc)
    end
    if params[:sort_priority]
      @tasks = current_user.tasks.all.order(priority: :asc)
    end
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if params[:task].present? && params[:task][:status].present?
        @tasks = current_user.tasks.search_title(title).search_status(status)
      elsif params[:task].present?
        @tasks = current_user.tasks.search_title(title)
      else params[:status].present?
        @tasks = current_user.tasks.search_status(status)
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました！"
    else
      render :new if @task.invalid?
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

  def own_task
    @task = Task.find(params[:id])
    unless current_user == Task.find(params[:id]).user
      redirect_to tasks_path, notice: '他人の情報にはアクセスできません'
    end
  end
end
