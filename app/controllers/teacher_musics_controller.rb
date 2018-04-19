class TeacherMusicsController < ApplicationController
    before_action :authenticate_user!
    before_action :is_user!    
    before_action only: [:index, :create] do
      authenticate_user_per_page!(1,musicteacherview_path)
    end
    before_action :authenticate_user_per_page!, only: [:show]
    def index
        @master_case = 0; 
        flash["formparam"]= {}
        #if flash["formparam"].nil? 
        #    flash["formparam"]= {}
        #end
                
        @teastatus = Tstatusjosb.all
        @teaposition = Tposition.all
        @teaunivers = Tuniversity.all
        @teatopic = Ttopic.all
        
        user = current_user
        questioncont =  Question.find_by({:title => "teachercount"})
        
                        #.page(params[:page])
        anscount  = 0
        
        if !questioncont.nil?
            answer = Answer.where(:question_id=>questioncont.id).where(:school_id=>user.school_id).first
            if !answer.nil?
                    flash["formparam"]["countteachers"] = answer.answer
                    if !answer.answer.nil? && !answer.answer.empty?
                        anscount = anscount + 1
                    end
                    #session["qid-#{q.id}"] = nil
            end
        end
        
        @teacers = Tanswer.where(:school_id=>user.school_id)
        @teacers.each do |tea|
            if !tea.nil?
                flash["formparam"]["teaprefix-#{tea.id}"] = tea.prefix
                flash["formparam"]["name-#{tea.id}"] = tea.name
                flash["formparam"]["surname-#{tea.id}"] = tea.surname
                flash["formparam"]["status-#{tea.id}"] = tea.status
                flash["formparam"]["position-#{tea.id}"] = tea.position
                findotherpos = Tposition.where(:title => tea.position)
                if findotherpos.length == 0 && !tea.position.nil? && !tea.position.empty?
                    flash["formparam"]["position-#{tea.id}"] = t("val.teachers.otherpleaseselect")
                    flash["formparam"]["otherposition-#{tea.id}"]  = tea.position
                end
                flash["formparam"]["degree-#{tea.id}"] = tea.degree
                flash["formparam"]["branch-#{tea.id}"] = tea.branch
                flash["formparam"]["university-#{tea.id}"] = tea.university
                finduniversity = Tuniversity.where(:title => tea.university)
                if finduniversity.length == 0 && !tea.university.nil? && !tea.university.empty?
                    flash["formparam"]["university-#{tea.id}"] = t("val.teachers.otherpleaseselect")
                    flash["formparam"]["otheruniversity-#{tea.id}"]  = tea.university
                end
                flash["formparam"]["topic-#{tea.id}"] = tea.topic
                findothertopic = Ttopic.where(:title => tea.topic)
                if findothertopic.length == 0 && !tea.topic.nil? && !tea.topic.empty?
                    flash["formparam"]["topic-#{tea.id}"] = t("val.teachers.otherpleaseselect")
                    flash["formparam"]["othertopic-#{tea.id}"]  = tea.topic
                end
                flash["formparam"]["remark-#{tea.id}"] = tea.remark
                if (!tea.prefix.nil? && !tea.prefix.empty?) || (!tea.name.nil? && !tea.name.empty?) ||
                    (!tea.surname.nil? && !tea.surname.empty?) || (!tea.status.nil? && !tea.status.empty?) ||
                    (!tea.position.nil? && !tea.position.empty?) || (!tea.degree.nil? && !tea.degree.empty?) ||
                    (!tea.branch.nil? && !tea.branch.empty?) || (!tea.university.nil? && !tea.university.empty?) ||
                    (!tea.topic.nil? && !tea.topic.empty?)
                    anscount = anscount + 1
                end
                #session["qid-#{q.id}"] = nil
            end
        end
        maxteacher = !(flash["formparam"]["countteachers"].nil?)?Integer(flash["formparam"]["countteachers"]):2 
        @formpercent = (anscount/((9.0 * maxteacher) + 1))*100.0
        
        #@answers1 = Answer.where(:musicin_id => @q1.id)
        #@answers1.each do |ans|
        #    flash["formparam"]["titleans-#{ans.id}"] = ans.othertitle
        #    flash["formparam"]["ans-#{ans.id}"] = ans.answer
        #    flash["formparam"]["ans-#{ans.id}-2"] = ans.answer2
        #end
        #@questions.group_by(&:musicin_id)
        deffobj = maxteacher - @teacers.length
        @diff = Array.new(deffobj)

        
    end
    def show
        @master_case = 0; 
        flash["formparam"]= {}
        #if flash["formparam"].nil? 
        #    flash["formparam"]= {}
        #end
                
        @teastatus = Tstatusjosb.all
        @teaposition = Tposition.all
        @teaunivers = Tuniversity.all
        @teatopic = Ttopic.all
        
        user = current_user
        questioncont =  Question.find_by({:title => "teachercount"})
        
                        #.page(params[:page])
        anscount  = 0
        
        if !questioncont.nil?
            answer = Answer.where(:question_id=>questioncont.id).where(:school_id=>user.school_id).first
            if !answer.nil?
                    flash["formparam"]["countteachers"] = answer.answer
                    if !answer.answer.nil? && !answer.answer.empty?
                        anscount = anscount + 1
                    end
                    #session["qid-#{q.id}"] = nil
            end
        end
        
        @teacers = Tanswer.where(:school_id=>user.school_id)
        @teacers.each do |tea|
            if !tea.nil?
                flash["formparam"]["teaprefix-#{tea.id}"] = tea.prefix
                flash["formparam"]["name-#{tea.id}"] = tea.name
                flash["formparam"]["surname-#{tea.id}"] = tea.surname
                flash["formparam"]["status-#{tea.id}"] = tea.status
                flash["formparam"]["position-#{tea.id}"] = tea.position
                findotherpos = Tposition.where(:title => tea.position)
                if findotherpos.length == 0 && !tea.position.nil? && !tea.position.empty?
                    flash["formparam"]["position-#{tea.id}"] = t("val.teachers.otherpleaseselect")
                    flash["formparam"]["otherposition-#{tea.id}"]  = tea.position
                end
                flash["formparam"]["degree-#{tea.id}"] = tea.degree
                flash["formparam"]["branch-#{tea.id}"] = tea.branch
                flash["formparam"]["university-#{tea.id}"] = tea.university
                finduniversity = Tuniversity.where(:title => tea.university)
                if finduniversity.length == 0 && !tea.university.nil? && !tea.university.empty?
                    flash["formparam"]["university-#{tea.id}"] = t("val.teachers.otherpleaseselect")
                    flash["formparam"]["otheruniversity-#{tea.id}"]  = tea.university
                end
                flash["formparam"]["topic-#{tea.id}"] = tea.topic
                findothertopic = Ttopic.where(:title => tea.topic)
                if findothertopic.length == 0 && !tea.topic.nil? && !tea.topic.empty?
                    flash["formparam"]["topic-#{tea.id}"] = t("val.teachers.otherpleaseselect")
                    flash["formparam"]["othertopic-#{tea.id}"]  = tea.topic
                end
                flash["formparam"]["remark-#{tea.id}"] = tea.remark
                if (!tea.prefix.nil? && !tea.prefix.empty?) || (!tea.name.nil? && !tea.name.empty?) ||
                    (!tea.surname.nil? && !tea.surname.empty?) || (!tea.status.nil? && !tea.status.empty?) ||
                    (!tea.position.nil? && !tea.position.empty?) || (!tea.degree.nil? && !tea.degree.empty?) ||
                    (!tea.branch.nil? && !tea.branch.empty?) || (!tea.university.nil? && !tea.university.empty?) ||
                    (!tea.topic.nil? && !tea.topic.empty?)
                    anscount = anscount + 1
                end
                #session["qid-#{q.id}"] = nil
            end
        end
        maxteacher = !(flash["formparam"]["countteachers"].nil?)?Integer(flash["formparam"]["countteachers"]):2 
        @formpercent = (anscount/((9.0 * maxteacher) + 1))*100.0
        
        #@answers1 = Answer.where(:musicin_id => @q1.id)
        #@answers1.each do |ans|
        #    flash["formparam"]["titleans-#{ans.id}"] = ans.othertitle
        #    flash["formparam"]["ans-#{ans.id}"] = ans.answer
        #    flash["formparam"]["ans-#{ans.id}-2"] = ans.answer2
        #end
        #@questions.group_by(&:musicin_id)
        deffobj = maxteacher - @teacers.length
        @diff = Array.new(deffobj)

        
    end
    def create
        user = current_user
        error_count = 0;
        track = Array.new 
        #track.push(params[:qparam])
        #add answer all
        params[:qparam].each do |k, v|
            karr = k.split('-') 
            case karr[0]
                when "countteachers"
                    if !v.nil? && !v.empty?
                         behavior = 0;
                         questioncont =  Question.find_by({:title => "teachercount"})
                         if !questioncont.nil?
                            answer = Answer.where(:question_id=> questioncont.id).where(:school_id=>user.school_id).first
                             if answer.nil?
                                          behavior = 4;
                                          #new data
                                          #tracharr.push("new case")
                                          ans = Answer.new({answer:v,question_id:questioncont.id,school_id:user.school_id});
                                          if ans.save
                                              track.push("save success")
                                          else
                                              error_count+=1
                                              track.push("save error")
                                          end
                            else
                                        #update data
                                         #tracharr.push("update case")
                                          if answer.answer != v
                                             behavior = 5;
                                              answer.update({answer:v});
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
                                loghistory({behavior:behavior,answer:v,question_id:questioncont.id,user_id:user.id},track)
                            end
                         end
                    end
                when "teaprefix" 
                    tid = Integer(karr[1])  
                    tprefix = v
                    
                    totherpos = params[:qparam]["otherposition-#{tid}"]
                    totherunivers = params[:qparam]["otheruniversity-#{tid}"]
                    tothertopic = params[:qparam]["othertopic-#{tid}"]
                    
                    tname = params[:qparam]["name-#{tid}"]
                    tsurname = params[:qparam]["surname-#{tid}"]
                    tstatus = params[:qparam]["status-#{tid}"]
                    tposition = (!totherpos.nil? && !totherpos.empty? ) ? totherpos : checkequalether(params[:qparam]["position-#{tid}"])
                    tdegree = params[:qparam]["degree-#{tid}"]
                    tbranch = params[:qparam]["branch-#{tid}"]
                    tuniversity = (!totherunivers.nil? && !totherunivers.empty? ) ? totherunivers : checkequalether(params[:qparam]["university-#{tid}"])
                    ttopic = (!tothertopic.nil? && !tothertopic.empty? ) ? tothertopic : checkequalether(params[:qparam]["topic-#{tid}"])
                    tremark = params[:qparam]["remark-#{tid}"]
                    
                    teacher = Tanswer.find_by(id: tid)
                    
                    behavior = 0;  
                        if !teacher.nil?
                            if teacher.prefix != tprefix || teacher.name != tname || teacher.surname != tsurname || teacher.status != tstatus || teacher.position != tposition || teacher.degree != tdegree || teacher.branch != tbranch || teacher.university != tuniversity || teacher.topic != ttopic || teacher.remark != tremark
                                 behavior = 5;
                                  teacher.update({
                                            prefix:tprefix,
                                            name:tname,
                                            surname:tsurname,
                                            status:tstatus,
                                            position:tposition,
                                            degree:tdegree,
                                            branch:tbranch,
                                            university:tuniversity,
                                            topic:ttopic,
                                            remark:tremark
                                  });
                                  if teacher.save
                                       track.push("update success")
                                  else
                                      error_count+=1
                                      track.push("update error")
                                  end
                             end
                        end
                        #Log history
                        if behavior > 0
                            logteacherhistory({
                                            behavior:behavior,
                                            prefix:tprefix,
                                            name:tname,
                                            surname:tsurname,
                                            status:tstatus,
                                            position:tposition,
                                            degree:tdegree,
                                            branch:tbranch,
                                            university:tuniversity,
                                            topic:ttopic,
                                            remark:tremark,
                                            user_id:user.id
                            },track)
                        end
                when "prefix"    
                    tprefix = Array(v)
                    
                    totherpos = Array(params[:qparam]["otherposition"])
                    totherunivers = Array(params[:qparam]["otheruniversity"])
                    tothertopic = Array(params[:qparam]["othertopic"])
                    
                    tname = Array(params[:qparam]["name"])
                    tsurname = Array(params[:qparam]["surname"])
                    tstatus = Array(params[:qparam]["status"])
                    tposition = Array(params[:qparam]["position"])
                    tdegree = Array(params[:qparam]["degree"])
                    tbranch = Array(params[:qparam]["branch"])
                    tuniversity = Array(params[:qparam]["university"])
                    ttopic = Array(params[:qparam]["topic"])
                    tremark = Array(params[:qparam]["remark"])
                    tprefix.each_with_index do |vd,index|
                         behavior = 0;    
                         
                         finalpos = (!totherpos[index].nil? && !totherpos[index].empty? ) ? totherpos[index] : checkequalether(tposition[index])
                         finalunivers = (!totherunivers[index].nil? && !totherunivers[index].empty? ) ? totherunivers[index] : checkequalether(tuniversity[index])
                         finaltopi = (!tothertopic[index].nil? && !tothertopic[index].empty? ) ? tothertopic[index] : checkequalether(ttopic[index])
                         
                         if (!vd.nil? && !vd.empty?)  && (!tname[index].nil? && !tname[index].empty?)
                             behavior = 4;
                              #new data
                              #tracharr.push("new case")
                              ans = Tanswer.new({
                                            prefix:vd,
                                            name:tname[index],
                                            surname:tsurname[index],
                                            status:tstatus[index],
                                            position:finalpos,
                                            degree:tdegree[index],
                                            branch:tbranch[index],
                                            university:finalunivers,
                                            topic:finaltopi,
                                            remark:tremark[index],
                                            school_id:user.school_id
                                      });
                              if ans.save
                                  track.push("save success")
                              else
                                  error_count+=1
                                  track.push("save error")
                              end
                         end
                        #Log history
                        if behavior > 0
                            logteacherhistory({
                                            behavior:behavior,
                                            prefix:vd,
                                            name:tname[index],
                                            surname:tsurname[index],
                                            status:tstatus[index],
                                            position:finalpos,
                                            degree:tdegree[index],
                                            branch:tbranch[index],
                                            university:finalunivers,
                                            topic:finaltopi,
                                            remark:tremark[index],
                                            user_id:user.id
                            },track)
                        end
                end    
            end
        end
        #add teacher info
        
        
        flash[:question_errors] = track
          redirect_to musicteacher_path
          if error_count == 0
            
             
          end
    end
    def delete
      mteacer = Tanswer.find(params[:id])
      mteacer.destroy
      redirect_to musicteacher_path
  end
    
    private
    def checkequalether(d)
            if d == t("val.teachers.otherpleaseselect")
                return ""
            end
        
        return d
    end
    def loghistory(param,track)
        #1 sign up
        #2 log in
        #3 log out
        #4 new data
        #5 update data
        loghis = Loghistory.new(param);
        if loghis.save
            track.push("log success")
        else
            track.push("log error")
        end
    end
    def logteacherhistory(param,track)
        #1 sign up
        #2 log in
        #3 log out
        #4 new data
        #5 update data
        loghis = Tloghistory.new(param);
        if loghis.save
            track.push("log success")
        else
            track.push("log error")
        end
    end
end
