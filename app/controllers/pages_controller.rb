class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  before_action :find_subject

  def index
    if @subject
      # @pages = Page.where(subject_id: @subject.id).sorted
      @pages = @subject.pages.sorted
    else
      @pages = Page.all.sorted
    end
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(
      subject_id: @subject.id,
      name: "Page_#{Utils.random_hash(size: 5)}"
    )
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end

  def create
    # page = Page.new(
    #   params[:page]
    #   .permit(
    #     :name, :position,
    #   :permalink, :visible)
    # )
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created succesfuly."
      redirect_to(action: 'index', :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render(:new)
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated succesfully."
      redirect_to(
        action: 'show', id: @page.id,
        :subject_id => @subject.id
      )
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
      render(:edit)
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id])
    page.destroy
    flash[:notice] = "Page destroyed succesfully."

    redirect_to(action: 'index', :subject_id => @subject.id)
  end

  private
  def page_params
    params.require(:page)
    .permit(:subject_id, :name, :position,
            :permalink, :visible)
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end

end
