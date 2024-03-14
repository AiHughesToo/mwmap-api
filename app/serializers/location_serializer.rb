class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :wp_user_id, :location_type, :image, :web, :social_one, :social_two, :email, :phone, :calendly, :service_types, 
  :description, :address_l1, :address_l2, :address_state, :address_city, :address_zip, :location_active, :rank
end
