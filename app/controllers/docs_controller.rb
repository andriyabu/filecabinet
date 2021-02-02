class DocsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_doc, only: [:edit, :update, :show, :destroy]
  def index
    @docs = Doc.all.where(user_id:current_user.id).order('created_at ASC')
  end

  def new
    @doc = current_user.docs.build
  end

  def create
    @doc = current_user.docs.build(doc_params)
    if @doc.save
      redirect_to @doc
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end


  def edit
  end

  def show
  end

  def update
      if @doc.update(doc_params)
        flash[:success] = "Document was successfully updated"
        redirect_to @doc
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end

  def destroy
    @doc.destroy
    redirect_to docs_path
  end

  
  private

  def find_doc
    @doc = Doc.find(params[:id])
  end

  def doc_params
    params.require(:doc).permit(:title,:body)
  end




end
