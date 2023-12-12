class LocationMailer < ApplicationMailer

    def lead_for_all_email(email, s_name, s_phone, s_email, message)
      
        @s_name = s_name
        @s_email = s_email
        @s_phone = s_phone
        @s_message = message
        mail(to: email, subjet: "New Map Lead")
  
      end
  
  
      def lead_for_one_email(email, business_name, s_name, s_phone, s_email, message)
     
        @s_name = s_name
        @s_email = s_email
        @s_phone = s_phone
        @b_name = business_name
        @s_message = message
        mail(to: email, subjet: "New Exclusive Map Lead")
  
      end

end
