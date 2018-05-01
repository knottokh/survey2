# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
   def new
     super
   end

  # POST /resource/password
   def create
     curemail = resource_params[:email].downcase
     adminemail = "merm.cu@gmail.com".downcase
     if curemail != adminemail
          user = User.find_by(:email => curemail)
          if !user.nil?
              self.resource = resource_class.send_reset_password_instructions(resource_params)
              yield resource if block_given?
              
              if !resource.nil?
                #reset_password_token = reset_password_token = Devise.token_generator.digest(resource, :reset_password_token, resource.reset_password_token)
                redirect_to edit_password_url(resource, reset_password_token: resource.send_reset_password_instructions )
                #flash[:dataresourse] = resource.send_reset_password_instructions+ "---"+resource.reset_password_token
                #redirect_to new_user_password_path
              else
                respond_with(resource)
              end
           else
             redirect_to new_user_password_path ,:notice => t("val.password.noemail") 
          end
     else
         redirect_to new_user_password_path ,:notice => t("val.password.adminnotallow") 
     end
      
   end

  # GET /resource/password/edit?reset_password_token=abcdef
   def edit
     super
   end

  # PUT /resource/password
   def update
     super
   end

  # protected

   def after_resetting_password_path_for(resource)
     super(resource)
   end

  # The path used after sending reset password instructions
   def after_sending_reset_password_instructions_path_for(resource_name)
     super(resource_name)
   end
end
