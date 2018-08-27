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
        if flash[:lastid].nil? or !flash[:lastid].present? or flash[:islast]
                 flash[:lastid] = 0
                 flash[:islast] = false
        end 
        limitrow = 20000
        # .order("percent_all desc") nulls last
        lastschoolobj = School.schoolpercent.order("id asc").last
        lastmodelid = (!lastschoolobj.nil? ? lastschoolobj.id : 0)
        schooldata = School.schoolpercent.where("id > #{flash[:lastid]}").limit(limitrow).order("id asc")
        flash[:lastid] = (!schooldata.last.nil? ? schooldata.last.id : 0)
        if flash[:lastid] === lastmodelid
            flash[:islast] = true
        end
        @dataexcel = Array.new
        @sheetname  = "school_summary"
        filename = "school_summary_#{Time.zone.now.strftime("%Y%m%d  %H%M%S")}_#{flash[:lastid]}_#{lastmodelid}"
        @headerarr  = ["id","ministry_code","school_name","percent_all","percent_1","percent_2","percent_3","percent_4","userinscool"]
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
  def exportExcelSideqid
      #ExportToExcelJob.perform_later()
      filename = "test_sidking_1"
      respond_to do |format|
                  format.html
                  format.xlsx do
                      #response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
                      ExportToExcelJob.perform_later
                    #response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
                    #render "testsidekiq.xlsx"
                 end  
      end
      #filename  = 'testnaja'
      #respond_to do |format|
      #            format.html
      #            format.xlsx do
      #              response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
      #              render "testsidekiq.xlsx"
      #            end  
      #end
  end
  def exportExcel
      
           
      if !params[:tablename].nil? and params[:tablename].present?
            if flash[:tablenametype].nil? or !flash[:tablenametype].present? or   flash[:tablenametype] != params[:tablename] or flash[:islast]
                 flash[:tablenametype] = params[:tablename]
                 flash[:lastid] = 0
                 flash[:islast] = false
            end 
            limitrow = 20000
            if !params[:rowlimit].nil? and params[:rowlimit].present?
                limitrow = Integer(params[:rowlimit])
            end
            if !params[:startid].nil? and params[:startid].present?
                flash[:lastid] = Integer(params[:startid])
            end
            
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
                flash[:tablenametype] = params[:tablename]
                lastschoolobj = model.order("id asc").last
                lastmodelid = (!lastschoolobj.nil? ? lastschoolobj.id : 0)
                modeldata = model.where("id > #{flash[:lastid]}").limit(limitrow).order("id asc")
                flash[:lastid] = (!modeldata.last.nil? ? modeldata.last.id : 0)
                if flash[:lastid] === lastmodelid
                    flash[:islast] = true
                end
                @dataexcel = Array.new
                @sheetname  = params[:tablename]
                filename = "#{params[:tablename]}_#{Time.zone.now.strftime("%Y%m%d  %H%M%S")}_#{flash[:lastid]}_#{lastmodelid}"
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
  def exportExcelCustomMerge
            if flash[:lastid].nil? or !flash[:lastid].present? or flash[:islast]
                 flash[:lastid] = 0
                 flash[:islast] = false
            end 
            limitrow = 500
            if !params[:rowlimit].nil? and params[:rowlimit].present?
                limitrow = Integer(params[:rowlimit])
            end
            if !params[:startid].nil? and params[:startid].present?
                flash[:lastid] = Integer(params[:startid])
            end
            
            model = School
            lastschoolobj = model.order("id asc").last
                lastmodelid = (!lastschoolobj.nil? ? lastschoolobj.id : 0)
                modeldata = model.where("id > #{flash[:lastid]}").limit(limitrow).order("id asc")
                flash[:lastid] = (!modeldata.last.nil? ? modeldata.last.id : 0)
                if flash[:lastid] === lastmodelid
                    flash[:islast] = true
                end
                @dataexcel = Array.new
                @sheetname  = "School Merge"
                filename = "School Merge_#{Time.zone.now.strftime("%Y%m%d  %H%M%S")}_#{flash[:lastid]}_#{lastmodelid}"
                @headerarr  = Array.new.concat(model.column_names)
                headerinsilde = Array.new.concat(model.column_names)
                questionList = Question.order("id asc")
                questionList.each do |qhdata|
                    @headerarr.push("QID_#{qhdata.title}_#{qhdata.id}_1")
                    @headerarr.push("QID_#{qhdata.title}_#{qhdata.id}_2")
                end      
                modeldata.each do |data|
                  dataarr = Array.new
                  dataarr = data.attributes.values_at(*headerinsilde)
                  questionList.each do |qdata|
                      answerList = Answer.where("school_id = #{data.id} and question_id = #{qdata.id}").last
                      if !answerList.nil?
                          dataarr.push(answerList.answer)
                          dataarr.push(answerList.answer2)
                      else
                          dataarr.push("-")
                          dataarr.push("-")
                      end
                  end  
                  @dataexcel.push(dataarr)
                end
                respond_to do |format|
                  format.html
                  format.xlsx do
                    response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
                    render "printexport.xlsx"
                  end  
                end
  end
def exportExcelTeacher
            if flash[:lastid].nil? or !flash[:lastid].present? or flash[:islast]
                 flash[:lastid] = 0
                 flash[:islast] = false
            end 
            limitrow = 500
            if !params[:rowlimit].nil? and params[:rowlimit].present?
                limitrow = Integer(params[:rowlimit])
            end
            if !params[:startid].nil? and params[:startid].present?
                flash[:lastid] = Integer(params[:startid])
            end
            
            model = Tanswer
            modelschool = School
            lastschoolobj = model.order("id asc").last
            lastmodelid = (!lastschoolobj.nil? ? lastschoolobj.id : 0)
            modeldata = model.joins(:school).select("tanswers.id as ansid,*").where("tanswers.id > #{flash[:lastid]}").limit(limitrow).order("tanswers.id asc")
                flash[:lastid] = (!modeldata.last.nil? ? modeldata.last.ansid : 0)
                if flash[:lastid] === lastmodelid
                    flash[:islast] = true
                end
                @dataexcel = Array.new
                @sheetname  = "Teacher Merge"
                filename = "Teacher Merge_#{Time.zone.now.strftime("%Y%m%d  %H%M%S")}_#{flash[:lastid]}_#{lastmodelid}"
                
                headerinsilde = ["ansid","prefix",
                    "name","surname","status","position","degree","branch","university","topic","remark","fromdep",
                    "school_id","education_area","ministry_code","school_name","municipal_area","district","province",
                    "postcode","zone","students_count","percent_all","percent_1","percent_2","percent_3","percent_4"]
                @headerarr  = Array.new.concat(headerinsilde)
                modeldata.each do |data|
                  dataarr = Array.new
                  dataarr = data.attributes.values_at(*headerinsilde)
                  @dataexcel.push(dataarr)
                end
                respond_to do |format|
                  format.html
                  format.xlsx do
                    response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
                    render "printexport.xlsx"
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
