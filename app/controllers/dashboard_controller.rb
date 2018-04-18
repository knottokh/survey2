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
     
     #count teacher
        qteacher =  Question.find_by({:title => "teachercount"})
        
                        #.page(params[:page])
        teachercount  = 0
        maxteacher = 0
            if !qteacher.nil?
            tanswer = Answer.where(:question_id=>qteacher.id).where(:school_id=>current_user.school_id).first
            if !tanswer.nil?
                    if !tanswer.answer.nil? && !tanswer.answer.empty?
                        maxteacher = Integer(tanswer.answer) 
                        teachercount = teachercount + 1
                    end
                    #session["qid-#{q.id}"] = nil
            end
        end
        teacers = Tanswer.where(:school_id=>current_user.school_id)
        teacers.each do |tea|
              if !tea.nil?
                  if (!tea.prefix.nil? && !tea.prefix.empty?) || (!tea.name.nil? && !tea.name.empty?) ||
                      (!tea.surname.nil? && !tea.surname.empty?) || (!tea.status.nil? && !tea.status.empty?) ||
                      (!tea.position.nil? && !tea.position.empty?) || (!tea.degree.nil? && !tea.degree.empty?) ||
                      (!tea.branch.nil? && !tea.branch.empty?) || (!tea.university.nil? && !tea.university.empty?) ||
                      (!tea.topic.nil? && !tea.topic.empty?)
                      
                       teachercount = teachercount + 1
                  end
                  #session["qid-#{q.id}"] = nil
              end
          end
     maxform1 = (9.0 * maxteacher) + 1
     #@formpercent = (teachercount/maxform1)*100.0
     
     #count thai music
     formdata2 = getMusicFormInfo(2,{})
     formdata3 = getMusicFormInfo(3,{})
     formdata4 = getMusicFormInfo(4,{})
     
     qmaxform2 = formdata2["allQ"].to_i
     qmaxform3 = formdata3["allQ"].to_i
     qmaxform4 = formdata4["allQ"].to_i
     
     amaxform2 = formdata2["allA"].to_i
     amaxform3 = formdata3["allA"].to_i
     amaxform4 = formdata4["allA"].to_i
     
     allcount =  maxform1+qmaxform2+qmaxform3+qmaxform4
     ansall = teachercount+amaxform2+amaxform3+amaxform4
     @percentall = (ansall).percent_of(allcount)  
     @percentform1 = (teachercount).percent_of(maxform1)  
     @percentform2 = amaxform2#(amaxform2).percent_of(qmaxform2)  
     @percentform3 = amaxform3#(amaxform3).percent_of(qmaxform3)   
     @percentform4 = amaxform4#(amaxform4).percent_of(qmaxform4)  
  end
end
