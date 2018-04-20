class SchoolsController < ApplicationController
    def allschools
      
      if !params[:term].nil? && !params[:term].empty?
          term = "%#{params[:term]}%"
          @schools = School.where("school_name like ? or ministry_code like ?", term,term)
      else
          @schools = School.all
      end

      @schools =  @schools.select("id,ministry_code,school_name").paginate(:page => params[:page], :per_page => params[:page_limit])

        respond_to do |format|  
            format.html
            format.json { 
              render :json => {
                :schools =>  @schools,
                :total =>  @schools.count,
                :links => { :self =>  @schools.current_page , :next =>  @schools.next_page},
                :term => params[:term]
            } 
          }
        end
   end
   def index
      respond_to do |format|
        format.html
        format.json { render json: SchoolDatatable.new(view_context) }
      end
   end
end
