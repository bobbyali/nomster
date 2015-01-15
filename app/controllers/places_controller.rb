class PlacesController < ApplicationController
  #before_action :authenticate_user!, :only => [:new, :create, :edit, :destroy, :update]

  def index
    @places = Place.all

    respond_to do |format|      
      format.html do 
      end

      format.json do 
        render :json => @places
      end
    end
    #@places = Place.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @place = Place.new
  end

  def about
  end

  def create
    #@place = current_user.places.create(place_params)
    @place = Place.create(place_params)

    respond_to do |format|
      format.html do 
        if @place.valid?
          redirect_to root_path
        else
          render :new, :status => :unprocessable_entity
        end
      end

      format.json do 
        if @place.valid?
          render :json => @place
        else
          render :json => @place, :status => :unprocessable_entity
        end  
      end
    end


  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new


    respond_to do |format|      
      format.html do 
      end
            
      format.json do 
        if @place.valid? 
          render :json => @place
        end
      end
    end
     
  end

  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @place.destroy
    flash[:alert] = "Place deleted"
    redirect_to root_path
  end

  private
    def place_params
      params.require(:place).permit(:name, :address, :description)
    end

end
