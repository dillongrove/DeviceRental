class DevicesController < ApplicationController
  load_and_authorize_resource

  def create
    @device = Device.new(params[:device])
    if @device.save
      flash[:notice] = "Successfully created device."
      redirect_to @device
    else
      render :action => 'new'
    end
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(params[:device])
      flash[:notice] = "Successfully updated device."
      redirect_to @device
    else
      render :action => 'edit'
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    flash[:notice] = "Successfully destroyed device."
    redirect_to devices_url
  end
end
