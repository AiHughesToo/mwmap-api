class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :wp_user_id, :location_type, :image, :web, :social_one, :social_two, :email, :phone, :calendly, :service_types, :description
end
