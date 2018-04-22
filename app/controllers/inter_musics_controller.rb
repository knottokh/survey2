class InterMusicsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_user!
    def index
        @master_case = 0; 
        #if flash["formparam"].nil? 
        flash["formparam"]= {}
        #end
        formdata = getMusicFormInfo(3,flash["formparam"])
        @formarray = formdata["alldata"]
        @formpercent =  !current_user.school.percent_3.nil?? current_user.school.percent_3 : 0 
        @musicclass = classMusicNotice2
        #@questions.group_by(&:musicin_id)
    end
    def show
        @master_case = 0; 
        #if flash["formparam"].nil? 
        flash["formparam"]= {}
        #end
        formdata = getMusicFormInfo(3,flash["formparam"])
        @formarray = formdata["alldata"]
        @formpercent = !current_user.school.percent_3.nil?? current_user.school.percent_3 : 0 
        @musicclass = classMusicNotice2
        #@questions.group_by(&:musicin_id)
    end
    
    #Post
  def create
      #qustions = Question.all
      saveandupdateMusics(params[:qparam],3)
      
      #flash[:question_errors] = track
      redirect_to intermusic_path
  end
  def delete
      deleteMusic(params[:id])
      redirect_to intermusic_path
  end
end
