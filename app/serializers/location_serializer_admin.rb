class LocationSerializerAdmin < ActiveModel::Serializer
    attributes :id, :name, :latitude, :longitude, :wp_user_id, :location_type, :image, :web, :insta, :faceb, :email, :phone, :calendly,
            :services, :address_l1, :address_l2, :address_state, :address_city, :address_zip, :rank, :purchased_lead_count, 
            :delivered_lead_count, :cms_id, :location_active
  end