class SubjectsController < ApplicationController
  # layout false
  layout "admin"

  before_action :confirm_logged_in

  def index
    # @subjects = Subject.order('position ASC')
    @subjects = Subject.sorted
  end

  def show
    # @subject = Subject.where(id: params[:id]).first
    @subject = Subject.find(params[:id])
  end

  def new
    # Setting some default values if needed
    @subject = Subject.new(name: 'Default')
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created sucessfully."
      redirect_to(action: 'index')
    else
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params)

      flash[:notice] = "Subject updated sucessfully."    
      redirect_to(action: 'show', id: @subject.id)
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
     @subject = Subject.find(params[:id])     
  end

  def destroy
    subject = Subject.find(params[:id])
    subject.destroy

    flash[:notice] = "Subject '#{subject.name}' destroyed sucessfully."
    redirect_to(action: 'index')
  end

  private
  def subject_params
    # same as using 'params[:subject]', except that it;
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:subject)
    .permit(:name, :position, :visible, :created_at)
  end

end
