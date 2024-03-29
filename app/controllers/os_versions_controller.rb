class OsVersionsController < ApplicationController
  load_and_authorize_resource

  def create
    @os_version = OsVersion.new(params[:os_version])
    if @os_version.save
      flash[:notice] = "Successfully created os_version."
      redirect_to @os_version
    else
      render :action => 'new'
    end
  end

  def update
    @os_version = OsVersion.find(params[:id])
    if @os_version.update_attributes(params[:os_version])
      flash[:notice] = "Successfully updated os_version."
      redirect_to @os_version
    else
      render :action => 'edit'
    end
  end

  def destroy
    @os_version = OsVersion.find(params[:id])
    @os_version.destroy
    flash[:notice] = "Successfully destroyed os_version."
    redirect_to os_versions_url
  end

end

