class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    #user_idをセット
    @task.user_id = current_user.id
    
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

  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end
