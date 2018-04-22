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
        
     @percentall = !current_user.school.percent_all.nil?? current_user.school.percent_all : 0  
     @percentform1 = !current_user.school.percent_1.nil?? current_user.school.percent_1 : 0   
     @percentform2 = !current_user.school.percent_2.nil?? current_user.school.percent_2 : 0   
     @percentform3 = !current_user.school.percent_3.nil?? current_user.school.percent_3 : 0  
     @percentform4 = !current_user.school.percent_4.nil?? current_user.school.percent_4 : 0 
  end
end
