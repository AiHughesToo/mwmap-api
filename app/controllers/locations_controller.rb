class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations
  def index
    @locations = Location.all

    render json: @locations, each_serializer: LocationSerializerAdmin
  end

  # GET /locations/1
  def show
    render json: @location, each_serializer: LocationSerializerAdmin
  end

  def find_map_locations
    locations = Location.where(location_type: params[:location_type], location_active: true).within(params[:range], :units => :miles, :origin => [params[:search_lat], params[:search_long]])
    # sort locations by rank - so highst rank will show in list first. 
    @sorted_locations = locations.sort_by { |l| l["rank"]}.reverse
    # eval the array here. decide which mailer to use. 
    @selected = @sorted_locations.select {|location| location["rank"] > 0}
    
    if @selected.empty?
      @sorted_locations.each do |l|
         LocationMailer.lead_for_all_email(l[:email], params[:s_name], params[:s_phone], params[:s_email], params[:s_message]).deliver_later
      end

    else
      has_purchased = @selected.select { |l| l["purchased_lead_count"] > 0}
      owed_leads = has_purchased.select { |l| l["delivered_lead_count"] < l["purchased_lead_count"]}

      if !has_purchased.empty? && !owed_leads.empty?
        
        # this would deliver the lead to the location with the lowest amount of delivvered leads
        # owed_leads = has_purchased.sort_by { |l| l["delivered_lead_count"] }
        
        #this delivers to the higest ranked location. 
        @prime_location = owed_leads.first
       
        LocationMailer.lead_for_one_email(@prime_location[:email], @prime_location[:name], params[:s_name], params[:s_phone], params[:s_email], params[:s_message]).deliver_now
       
        @prime_location[:delivered_lead_count] = @prime_location[:delivered_lead_count] + 1

        @prime_location.save
     else
        @sorted_locations.each do |l|
          LocationMailer.lead_for_all_email(l[:email], params[:s_name], params[:s_phone], params[:s_email], params[:s_message]).deliver_later
        end
     end
    end
    
    #this returns locations in order of rank. 
    render json: @sorted_locations
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
                                        :image, :web, :social_one, :social_two, :email, :phone, :calendly, 
                                        :range, :search_lat, :search_long, :service_types, :address_l1, :address_l2, 
                                        :address_state, :address_city, :address_zip, :rank, :purchased_lead_count,
                                        :delivered_lead_count, :cms_id, :location_active, :s_name, :s_email, :s_phone, :s_message)
    end
end
