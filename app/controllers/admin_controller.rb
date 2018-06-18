class AdminController < ApplicationController
    before_action :authenticate_user!, only: [:index]
    before_action :is_admin!, only: [:index]
    def index
        @master_case = 99
        
        school_count = School.count
        @school_registed_count  = User.school_registed
        @user_count = User.user_registed
        formall_success  = School.schoolpercent.group("id").having("percent_all = 100").map {|i| i.id }.count
        form1_success  = School.schoolpercent.group("id").having("percent_1 = 100").map {|i| i.id }.count
        form2_success  = School.schoolpercent.group("id").having("percent_2 = 100").map {|i| i.id }.count
        form3_success  = School.schoolpercent.group("id").having("percent_3 = 100").map {|i| i.id }.count
        form4_success  = School.schoolpercent.group("id").having("percent_4 = 100").map {|i| i.id }.count
        @school_registed_percent  = @school_registed_count.percent_of(school_count)
        @formall_success_percent  = formall_success.percent_of(school_count)
        @form1_success_percent  = form1_success.percent_of(school_count)
        @form2_success_percent  = form2_success.percent_of(school_count)
        @form3_success_percent  = form3_success.percent_of(school_count)
        @form4_success_percent  = form4_success.percent_of(school_count)
        
    end
    #dashboard
    def show
        @master_case = 99
        @dbtype = ["Music Answer", #answers
        "Log Music Answer", #loghistories
        "Form Lock User", #formmanages
        "Teacher Answer", #tanswers
        "Log Teacher Answer", #tloghistories
        "Users", #users
        "ALL Universities", #tuniversities
        "ALL Topices", #ttopics
        "ALL Status Jobs", #tstatusjosbs
        "ALL Positions", #tpositions
        "ALL Degree", #tdegrees
        "ALL Musics", #musictypes
        "ALL Question", #questions
        "ALL Schools"] #schools
        
    end
    
    def searchuser
        @searchuser = nil
        if !params[:name].nil? and params[:name].present? and !params[:surname].nil? and params[:surname].present?
           @searchuser = User.joins(:school).select("*,users.id uid").where("users.name like '%#{params[:name]}%' or users.surname like '%#{params[:surname]}%'")
        elsif !params[:name].nil? and params[:name].present? 
        @searchuser = User.joins(:school).select("*,users.id uid").where("users.name like '%#{params[:name]}%'")
        elsif !params[:surname].nil? and params[:surname].present? 
          @searchuser = User.joins(:school).select("*,users.id uid").where("users.surname like '%#{params[:surname]}%'")
        end
        respond_to do |format|  
            format.html
            format.json { 
              render :json => { :users =>  @searchuser} 
          }
      end
    end
    def updateuserschool
        returns = "none"
        if !params[:id].nil? and params[:id].present? and !params[:schoolid].nil? and params[:schoolid].present?
            us = User.find(params[:id])
            if !us.nil?
                us.update({school_id: params[:schoolid]})
                returns = us.save
            end
        end    
        respond_to do |format|  
            format.html
            format.json { 
              render :json => {:result => returns}
        }
        end
    end
    def exportTo
        @todolistall = School.all
        filename = "exportnaja"
        respond_to do |format|
            format.html
            format.csv { send_data to_csv(@todolistall,nil,{encoding: 'UTF-8'}) ,:type => 'charset=utf-8; header=present' , :filename => 'exportjaja.csv'}
            #format.csv {send_data Iconv.conv('iso-8859-1//IGNORE', 'utf-8', to_csv(@todolistall,nil,{encoding: 'UTF-8'})),
            #              :type => 'text/csv; charset=iso-8859-1; header=present',
            #              :disposition => "attachment; filename=#{filename}.csv"}
            #format.xlsx { send_data to_csv(@todolistall)}
        end
    end
    def exportAminTable
        schooldata = School.schoolpercent.order("percent_all desc nulls last")
        @dataexcel = Array.new
        @sheetname  = "school_summary"
        filename = "school_summary_#{Time.zone.now.strftime("%Y%m%d  %H%M%S")}"
        @headerarr  = ["ministry_code","school_name","percent_all","percent_1","percent_2","percent_3","percent_4","userinscool"]
        schooldata.each do |data|
          @dataexcel.push(data.attributes.values_at(*@headerarr))
        end
        respond_to do |format|
          format.html
          format.xlsx do
            response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
            render "printexport.xlsx"
          end  
        end
    end
  def exportExcel
      if !params[:tablename].nil? and params[:tablename].present?
            
            model = nil
            
            case params[:tablename]
               when "Music Answer"
                    model = Answer
               when "Log Music Answer"
                    model = Loghistory  
               when "Form Lock User"
                    model = Formmanage   
               when "Teacher Answer"
                    model = Tanswer  
               when "Log Teacher Answer"
                    model = Tloghistory      
               when "Users"
                    model = User  
               when "ALL Universities"
                    model = Tuniversity   
               when "ALL Topices"
                    model = Ttopic  
               when "ALL Status Jobs"
                    model = Tstatusjosb
               when "ALL Positions"
                    model = Tposition  
               when "ALL Degree"
                    model = Tdegree   
               when "ALL Musics"
                    model = Musictype  
               when "ALL Question"
                    model = Question   
               when "ALL Schools"
                    model = School  
            end
            if !model.nil?
                modeldata = model.all
                @dataexcel = Array.new
                @sheetname  = params[:tablename]
                filename = "#{params[:tablename]}_#{Time.zone.now.strftime("%Y%m%d  %H%M%S")}"
                @headerarr  = model.column_names
                modeldata.each do |data|
                  @dataexcel.push(data.attributes.values_at(*@headerarr))
                end
                respond_to do |format|
                  format.html
                  format.xlsx do
                    response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
                    render "printexport.xlsx"
                  end  
                end
            end    
        end    
  end    
  def import
      # @anser1 = sum_all_teacher_by_school(1)#select_music_school(1,'(2,3,4)','IN')
      #@anser1 = Devise::Encryptors::Aes256.decrypt("$2a$11$YtzV.NT9eXIqnOi0iSCLmO5AqOgF8YKq7Pda5lZUdNjsO.NAkwFY2" , Devise.pepper)
  end
  def importpost
      tablecol = nil
      model = nil
      case params[:dbtable]
        when "School"
            model = School
            tablecol  = ["education_area","ministry_code","school_name","municipal_area","district","province","postcode","zone","students_count"]
        when "Question"
            model = Question
            tablecol  = ["title","qtype","musictype_id"]    
      end
      if !tablecol.nil? && !model.nil?        
          importfile(model,tablecol,params[:file])
          flash[:importmsg] = ["Import Success"]
      else
          flash[:importmsg] = ["Can't Import"]
      end
      render action: :import
  end
  def getuserinfo
      alluser = User.user_findbyschool(params[:schoolid])
      respond_to do |format|  
            format.html
            format.json { 
              render :json => { :users =>  alluser ,:schoolid => params[:schoolid]} 
          }
      end
  end
end
