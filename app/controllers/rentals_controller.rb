class RentalsController < ApplicationController
  load_and_authorize_resource

  def new  
    @rental = Rental.new  
    @device =  Device.find(params[:device])
  end

  def create
    @rental = Rental.new(params[:rental])

    if current_user.role? :admin
      @rental.user_id = params[:rental][:user_id]
    else
      @rental.user_id = current_user.id
    end

    if @rental.save
      flash[:notice] = "Successfully created rental."
      if current_user.role? :admin
        return redirect_to home_path
      else 
        return redirect_to user_path(current_user)
      end
    else
      return render :action => 'new'
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
