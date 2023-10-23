class UserSerializer < ActiveModel::Serializer
  attributes :id, :f_name, :l_name, :email, :account_type, :wp_user_id
end
