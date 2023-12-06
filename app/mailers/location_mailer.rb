class LocationMailer < ApplicationMailer


    def lead_for_all_email(email, s_name, s_phone, s_email)
      p "im in the locations mailer."
      p email
      @s_name = s_name
      @s_email = s_email
      @s_phone = s_phone
      mail(to: email, subjet: "New Map Lead")

    end


    def lead_for_one_email(email, s_name, s_phone, s_email)
      p "im in the locations mailer."
      p email
      @s_name = s_name
      @s_email = s_email
      @s_phone = s_phone
      mail(to: email, subjet: "New Exclusive Map Lead")

    end
  
    
  end