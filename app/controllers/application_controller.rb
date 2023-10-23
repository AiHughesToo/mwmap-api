class ApplicationController < ActionController::API
   
    def authenticate_token!
        payload = JsonWebToken.decode(auth_token)
        @current_user = User.find(payload['sub'])
      rescue JWT::DecodeError
        render json: { errors: 'Invalid web token.' }, status: :unauthorized
      end
    
      # this pulls the last part of the token passed in the Authorization header and assigns it to auth_token
      def auth_token
        @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
      end
    
      # Rescue when find(id) fails
      rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
      rescue_from ActiveRecord::RecordNotUnique, :with => :record_not_unique
    
      def record_not_found
        render json: { errors: 'That Record does not exist.' }, status: :unprocessable_entity
      end
    
      def record_not_unique
        render json: { errors: 'That is not unique.' }, status: :unprocessable_entity
      end
end
