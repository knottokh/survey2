class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  
  protect_from_forgery with: :exception
  
  
  
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:password,:password_confirmation,
                        :school_id,:prefix,:name,:surname,:cardnumber,:position,
                        :phone,:email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:password,:password_confirmation,
                        :school_id,:prefix,:name,:surname,:cardnumber,:position,
                        :phone,:email])
  end
  
  def authenticate_user_per_page!(type = nil,view_path = nil)
      if  !type.nil?
        # user log in control page (lock page)
        formcheck = Formmanage.where('formtype = ? AND school_id = ?', type, current_user.school_id)
        if formcheck.nil? ||  formcheck.count == 0
            formcheck = Formmanage.new({islock: true,formtype: type,school_id: current_user.school_id,user_id: current_user.id})
            formcheck.save
        else
           # time_difference_in_sec = (DateTime.now.to_time.to_i - @given_time.to_time.to_i).abs
           formcheck = formcheck.last
           if !formcheck.islock 
               #case no user access
               formcheck.update_attributes({islock: true , user_id: current_user.id,updated_at: DateTime.now.to_time})
               formcheck.save
           else        
               #case user access
               if formcheck.user_id == current_user.id
                   #update time
                   formcheck.update_attributes({islock: true,updated_at: DateTime.now.to_time})
                   formcheck.save
               else
                   time_difference_in_sec = (DateTime.now.to_time.to_i - formcheck.updated_at.to_time.to_i).abs
                   maxmin = 15
                   min_in_sec = maxmin* 60
                   if time_difference_in_sec > min_in_sec
                       #force unlock
                       formcheck.update_attributes({islock: true , user_id: current_user.id,updated_at: DateTime.now.to_time})
                       formcheck.save
                   else
                      redirect_to  view_path, notice: "Some one aready access!"
                   end        
               end   
            end   
        end
      else 
        #user log in other page (unlock page)
        allformiamowner = Formmanage.where('user_id = ? AND school_id = ?', current_user.id, current_user.school_id)
        if !allformiamowner.nil? && allformiamowner.count > 0
            allformiamowner.update_all islock: false
        end
      end
  end
  def set_locale
    session[:locale] = "th"
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
  end
  
  
  def is_admin!
    if !current_user.admin? 
      #sign_out(current_user)
      redirect_to dashboard_path ,notice: "You trying to access without permission role Admin!"
    end 
  end
  def is_user!
    if !current_user.user? 
      #sign_out(current_user)
      redirect_to admin_path ,notice: "You trying to access without permission role User!"
    end 
  end
  def importfile(model,accessible_attributes=nil,file)
      spreadsheet = open_spreadsheet(file)
      desired_columns = accessible_attributes || model.column_names
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        improtmol = model.find_by_id(row["id"]) || model.new
        improtmol.attributes = row.to_hash.slice(*desired_columns)
        improtmol.save!
      end
  end
    
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
       when '.csv' then Roo::Csv.new(file.path)
       when '.xls' then Roo::Excel.new(file.path)
       when '.xlsx' then Roo::Excelx.new(file.path)
       else raise "Unknown file type: #{file.original_filename}"
      end
    end
    def to_csv(model,accessible_attributes = nil,options = {})
      desired_columns = accessible_attributes || model.column_names
      CSV.generate(options) do |csv|
        csv << desired_columns
        model.each do |data|
          csv << data.attributes.values_at(*desired_columns)
        end
      end
    end 
    def getMusicFormInfo(formtype,cursession)
        user = current_user
        
        musicins = Musictype.where(:formtype => formtype).order(:orderno => :asc)
        anscount  = 0
        questioncount = 0
        returnobject = {}
        queryAll = Array.new
        musicins.each do |mus|
          subquery =  {}
          subquery["musicin"] = mus
          questions = Question.where(:musictype_id => mus.id)
                          #.page(params[:page])
          questions.each do |q|
              answer = Answer.where(:question_id=>q.id).where(:school_id=>user.school_id).first
              if !answer.nil?
                  cursession["qid-#{q.id}"] = answer.answer
                  cursession["qid-#{q.id}-2"] = answer.answer2
                  if !answer.answer.nil? && !answer.answer.empty?
                      anscount = anscount + 1
                  end
                  if !answer.answer2.nil? && !answer.answer2.empty?
                      anscount = anscount + 1
                  end
                  #session["qid-#{q.id}"] = nil
              end
          end
          
          questioncount = questioncount + questions.count;
          answers = Answer.where(:musictype_id => mus.id)
          answers.each do |ans|
              cursession["titleans-#{ans.id}"] = ans.othertitle
              cursession["ans-#{ans.id}"] = ans.answer
              cursession["ans-#{ans.id}-2"] = ans.answer2
          end
          subquery["questions"] = questions;
          subquery["answers"] = answers
          queryAll.push(subquery)
        end 
        returnobject["alldata"] =   queryAll
        returnobject["percent"] = (anscount/(questioncount*2.0))*100.0
        returnobject["allQ"]  = (questioncount*2.0);
        returnobject["allA"] = anscount
        
       return returnobject  
    end
    def classMusicNotice
        return Array.new(["info","success","warning","danger"])
    end
    
  def checktext(percent)
     if percent == 100
         return "แก้ไข"
      elsif percent === 0
        return "กรอกข้อมูล"
      else 
         return "กรอกข้อมูลต่อ"
     end
          
  end    
  def saveandupdateMusics(qparam)
      user = current_user
      error_count = 0;
      track = Array.new 
      track.push(qparam)
      #@pages = Pages.new(params[:qparam])
      #tracharr.push(@pages)
      qparam.each do |k, v|
        #v['contact_ids'] = [ v['contact_ids'] ] unless v['contact_ids'].is_a?(Array)
        if !v.nil?
              karr = k.split('-') 
              case karr[0]
                when "qid"
                    if karr.length == 2
                        qid = Integer(karr[1])  
                        v2 = qparam["qid-#{qid}-2"]
                        behavior = 0;
                        answer = Answer.where(:question_id=>qid).where(:school_id=>user.school_id).first
                        if answer.nil?
                              behavior = 4;
                              #new data
                              #tracharr.push("new case")
                              ans = Answer.new({answer:v,answer2:v2,question_id:qid,school_id:user.school_id});
                              if ans.save
                                  track.push("save success")
                              else
                                  error_count+=1
                                  track.push("save error")
                              end
                        else
                            #update data
                             #tracharr.push("update case")
                              if answer.answer != v || answer.answer2 != v2 
                                 behavior = 5;
                                  answer.update({answer:v,answer2:v2});
                                  if answer.save
                                       track.push("update success")
                                  else
                                      error_count+=1
                                      track.push("update error")
                                  end
                              end
                            #redirect_to dashboard_path
                        end
                        
                        #Log history
                        if behavior > 0
                            loghistory({behavior:behavior,answer:v,answer2:v2,question_id:qid,user_id:user.id},track)
                        end
                    end
                   #answer = User.find_by(id: session[:user_id])
                                
                when "othertitle"
                    objv = Array(v)
                    musid = Integer(karr[1])
                    objans1 = Array(qparam["otherval-#{musid}"])
                    objans2 = Array(qparam["otherval2-#{musid}"])
                    objv.each_with_index do |vd,index|
                         behavior = 0;    
                         if !vd.nil? && !vd.empty?
                             behavior = 4;
                              #new data
                              #tracharr.push("new case")
                              ans = Answer.new({answer:objans1[index],answer2:objans2[index],othertitle:vd,musictype_id:musid,school_id:user.school_id});
                              if ans.save
                                  track.push("save success")
                              else
                                  error_count+=1
                                  track.push("save error")
                              end
                         end
                        #Log history
                        if behavior > 0
                            loghistory({behavior:behavior,answer:objans1[index],answer2:objans2[index],othertitle:vd,musictype_id:musid,user_id:user.id},track)
                        end
                    end
                when "titleans"
                    if karr.length == 2
                        ansid = Integer(karr[1])
                        anstext= qparam["ans-#{ansid}"]
                        anstext2 =qparam["ans-#{ansid}-2"]
                        answer = Answer.find_by(id: ansid)
                        behavior = 0;  
                        if !answer.nil?
                            if answer.answer != anstext || answer.answer2 != anstext2 || answer.othertitle != v 
                                 behavior = 5;
                                  answer.update({othertitle:v,answer:anstext,answer2:anstext2});
                                  if answer.save
                                       track.push("update success")
                                  else
                                      error_count+=1
                                      track.push("update error")
                                  end
                             end
                        end
                        if behavior > 0
                            loghistory({behavior:behavior,answer:anstext,answer2:anstext2,othertitle:v,musictype_id:answer.musictype_id,user_id:user.id},track)
                        end
                    end
                #else
                #  "You gave me #{x} -- I have no idea what to do with that."
               end
               
        end
      end
  end
  def deleteMusic(id)
      delans = Answer.find(id)
      track = Array.new 
      loghistory({behavior:6,answer:delans.answer,answer2:delans.answer2,othertitle:delans.othertitle,musictype_id:delans.musictype_id,user_id:current_user.id},track)
      delans.destroy
  end

  def loghistory(param,track)
        #1 sign up
        #2 log in
        #3 log out
        #4 new data
        #5 update data
        #6 delete data
        loghis = Loghistory.new(param);
        if loghis.save
            track.push("log success")
        else
            track.push("log error")
        end
  end
end
class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.00
  end
end
