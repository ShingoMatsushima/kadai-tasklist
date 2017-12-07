class TasksController < ApplicationController
 before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクを登録しました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの登録に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
   if @task.update(task_params)
      flash[:success] = "タスクを変更しました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの変更に失敗しました"
      render :edit
    end
  end

  def destroy
     @task.destroy

    flash[:success] = "タスクを削除しました"
    redirect_to tasks_url
  end

  private

  def set_message
    @task = Task.find(params[:id])
  end

  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
