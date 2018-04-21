class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user! 
  before_action :authenticate_user_per_page!
  def index
     
     loguserlogin = Loghistory.where(:user_id => current_user.id,:behavior => "2").last
     #loglogin = Loghistory.where()
     #I18n.locale = :th
     @userlogintime = ""#I18n.l(Date.current) 
     if !loguserlogin.nil?
          @userlogintime = I18n.l(loguserlogin.created_at.in_time_zone("Bangkok"), format: :long)#loguserlogin.created_at.strftime("%d-%m-%Y")
     end     
        
     @percentall = current_user.school.percent_all  
     @percentform1 = current_user.school.percent_1    
     @percentform2 = current_user.school.percent_2   
     @percentform3 = current_user.school.percent_3    
     @percentform4 = current_user.school.percent_4  
  end
end
