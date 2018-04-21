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
    def show
        
    end
    def exportTo
        @todolistall = Musicin.all
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
  def import
       @anser1 = sum_all_teacher_by_school(1)#select_music_school(1,'(2,3,4)','IN')
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
