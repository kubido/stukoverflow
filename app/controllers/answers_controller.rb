class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      flash[:success] = 'Jawaban berhasil dibuat.'
    else
      flash[:danger] = 'Jawaban gagal dibuat.'
    end
    redirect_to question_path(params[:question_id])
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      flash[:success] = 'Jawaban berhasil diperbarui.'
    end
    redirect_to question_path(params[:question_id])
  end

  def destroy
    if @answer.destroy
      flash[:success] = 'Jawaban berhasil dihapus.'
    end
    redirect_to question_path(params[:question_id])
  end

  private
    def set_answer
      @answer = Answer.find_by(question_id: params[:question_id], id: params[:id])
    end

    def answer_params
      params.require(:answer)
        .permit(:body)
        .merge(user_id: current_user.id, question_id: params[:question_id])
    end
end
