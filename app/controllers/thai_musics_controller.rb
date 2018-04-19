class ThaiMusicsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_user!
    def index
        @master_case = 0; 
        #if flash["formparam"].nil? 
        flash["formparam"]= {}
        #end
        formdata = getMusicFormInfo(2,flash["formparam"])
        @formarray = formdata["alldata"]
        @formpercent = formdata["percent"]
        @musicclass = classMusicNotice
        #@questions.group_by(&:musicin_id)
    end
    def show
        @master_case = 0; 
        #if flash["formparam"].nil? 
        flash["formparam"]= {}
        #end
        formdata = getMusicFormInfo(2,flash["formparam"])
        @formarray = formdata["alldata"]
        @formpercent = formdata["percent"]
        @musicclass = classMusicNotice
        #@questions.group_by(&:musicin_id)
    end
    
    #Post
  def create
      #qustions = Question.all
      saveandupdateMusics(params[:qparam])
      
      #flash[:question_errors] = track
      redirect_to thaimusic_path
  end
  def delete
      deleteMusic(params[:id])
      redirect_to thaimusic_path
  end
end
