class RentalsController < ApplicationController

  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def create
    @rental = Rental.new(params[:rental])
    if @rental.save
      flash[:notice] = "Successfully created rental."
      redirect_to @rental
    else
      render :action => 'new'
    end
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update_attributes(params[:rental])
      flash[:notice] = "Successfully updated rental."
      redirect_to @rental
    else
      render :action => 'edit'
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
    flash[:notice] = "Successfully destroyed rental."
    redirect_to rentals_url
  end

end
