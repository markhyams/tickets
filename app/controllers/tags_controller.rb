class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash['success'] = 'Tag created.'
      redirect_to tags_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    @tag.update(tag_params)

    if @tag.save
      flash['success'] = 'Tag updated.'
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    flash['primary'] = 'Tag deleted.'
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end