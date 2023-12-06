class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  def index
    @locations = Location.all

    render json: @locations, each_serializer: LocationSerializerAdmin
  end

  # GET /locations/1
  def show
    render json: @location
  end

  def find_map_locations
    @locations = Location.where(location_type: params[:location_type]).within(params[:range], :units => :miles, :origin => [params[:search_lat], params[:search_long]])
    
    # eval the array here. decide which mailer to use. 
    @selected = @locations.select {|location| location["rank"] > 0}
    p "SELECTED"
    p @selected
    if @selected.empty?
      p "all are rank 0"
      @locations.each do |l|
         LocationMailer.lead_for_all_email(l[:email], params[:s_name], params[:s_phone], :params[:s_email]).deliver_now
      end

    else
      p "IM HERE 1"
     has_purchased = @selected.select { |l| l["purchased_lead_count"] > 0}
     p "IM HERE 2"
     if !has_purchased.empty?
      p "IM HERE 3"
      owed_leads = has_purchased.sort_by { |l| l["delivered_lead_count"] }
     # prime_location = owed_leads.first
      p owed_leads.first["email"]
      #  LocationMailer.lead_for_one_email(prime_location["email"], params[:s_name], params[:s_phone], :params[:s_email]).deliver_now
      #  p prime_location["delivered_lead_count"]
      #  prime_location["delivered_lead_count"]++
      #  p prime_location["delivered_lead_count"]
      #  prime_location.save
     else
      @locations.each do |l|
        LocationMailer.lead_for_all_email(l["email"], params[:s_name], params[:s_phone], :params[:s_email]).deliver_now
      end
     end
    end
    

    render json: @locations
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      render json: @location, status: :created, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      render json: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:name, :latitude, :longitude, :wp_user_id, :location_type, 
                                        :image, :web, :insta, :faceb, :email, :phone, :calendly, 
                                        :range, :search_lat, :search_long, :services, :address_l1, :address_l2, 
                                        :address_state, :address_city, :address_zip, :rank, :purchased_lead_count,
                                        :delivered_lead_count, :cms_id, :location_active, :s_name, :s_email, :s_phone)
    end
end
