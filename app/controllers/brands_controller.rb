class BrandsController < ApplicationController
  load_and_authorize_resource

  def create
    @brand = Brand.new(params[:brand])
    if @brand.save
      flash[:notice] = "Successfully created brand."
      redirect_to @brand
    else
      render :action => 'new'
    end
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update_attributes(params[:brand])
      flash[:notice] = "Successfully updated brand."
      redirect_to @brand
    else
      render :action => 'edit'
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    flash[:notice] = "Successfully destroyed brand."
    redirect_to brands_url
  end

end
