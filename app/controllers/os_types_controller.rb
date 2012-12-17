class OsTypesController < ApplicationController
  load_and_authorize_resource

  def create
    @os_type = OsType.new(params[:os_type])
    if @os_type.save
      flash[:notice] = "Successfully created os_type."
      redirect_to @os_type
    else
      render :action => 'new'
    end
  end

  def update
    @os_type = OsType.find(params[:id])
    if @os_type.update_attributes(params[:os_type])
      flash[:notice] = "Successfully updated os_type."
      redirect_to @os_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    @os_type = OsType.find(params[:id])
    @os_type.destroy
    flash[:notice] = "Successfully destroyed os_type."
    redirect_to os_types_url
  end
  
end
