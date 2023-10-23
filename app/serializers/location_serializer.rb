class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :wp_user_id, :location_type, :image, :web, :insta, :faceb, :email, :phone, :calendly
end
