class School < ApplicationRecord

  
  has_many :users  
  has_many :answers 
  has_many :tanswers  
  has_many :loghistories 
  has_many :tloghistories 
  has_many :formmanages 
    def self.schoolpercent
        select("*,	(
                                (    (
                                      (select (sum (m) + 1) mms from ( select (
                                        ((CASE WHEN  (T.prefix IS NOT NULL AND T.prefix <> '' ) THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.name IS NOT NULL AND T.name <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.surname IS NOT NULL AND T.surname <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.status IS NOT NULL AND T.status <> '')  THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.position IS NOT NULL AND T.position <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.degree IS NOT NULL  AND T.degree <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.branch IS NOT NULL AND T.branch <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.university IS NOT NULL AND T.university <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.topic IS NOT NULL  AND T.topic <> '') THEN 1 ELSE 0 END)) 
                                      ) m
                                      from tanswers T  where T.school_id =  schools.id)
                                      ) 
                                      /
                                     ( (
                                     
                                        select SUM(a.answer)
                                            from answers a INNER JOIN questions q on a.question_id = q.id 
                                           where  a.school_id = schools.id and  a.question_id = #{q1max} 
                                      
                                      ) * 9.00 +1)
                                      ) * 100
                                      )
                                    ) percent_1,
                                    ( 
                                     (  (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musictypes M on Q.musictype_id = M.id 
                                          Where A.school_id = schools.id and M.formtype = 2
                                          )
                                        ) / #{q2max} ) * 100
                                    
                                  ) percent_2,( 
                                     (  (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musictypes M on Q.musictype_id = M.id 
                                          Where A.school_id = schools.id and M.formtype = 3
                                          )
                                        ) / #{q3max} ) * 100
                                    
                                  ) percent_3,( 
                                     (  (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musictypes M on Q.musictype_id = M.id 
                                          Where A.school_id = schools.id and M.formtype = 4
                                          )
                                        ) / #{q4max} ) * 100
                                    
                                  ) percent_4,( 
                                    (
                                      (select (CASE WHEN count(m) > 0 THEN sum (m) + 1 ELSE 0 END) from ( select (
                                        ((CASE WHEN  (T.prefix IS NOT NULL AND T.prefix <> '' ) THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.name IS NOT NULL AND T.name <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.surname IS NOT NULL AND T.surname <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.status IS NOT NULL AND T.status <> '')  THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.position IS NOT NULL AND T.position <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.degree IS NOT NULL  AND T.degree <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.branch IS NOT NULL AND T.branch <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.university IS NOT NULL AND T.university <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.topic IS NOT NULL  AND T.topic <> '') THEN 1 ELSE 0 END)) 
                                      ) m
                                      from tanswers T  where T.school_id =  schools.id)
                                      ) 
                                      +
                                      (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musictypes M on Q.musictype_id = M.id 
                                          Where A.school_id = schools.id and M.formtype IN (2,3,4)
                                          )
                                        )
                                      )
                                      /
                                      ( 
                                        ( (
                                     
                                            select SUM(a.answer)
                                                from answers a INNER JOIN questions q on a.question_id = q.id 
                                               where  a.school_id = schools.id and  a.question_id = #{q1max} 
                                          
                                          ) * 9.00 +1)
                                          +
                                          #{ q2max + q3max + q4max}
                                       ) * 100
                                     ) percent_all,(Select count(users.id) from users where users.school_id = schools.id) userinscool")
    end
  
    private 
    def self.q1max
      Question.joins(:musictype).where(:musictypes => {formtype:1}).last.id
    end
    def self.q2max
       Question.joins(:musictype).where(:musictypes => {formtype:2}).count * 2.00  
    end
    def self.q3max
        Question.joins(:musictype).where(:musictypes => {formtype:3}).count * 2.00
    end
    def self.q4max
        Question.joins(:musictype).where(:musictypes => {formtype:4}).count * 2.00
    end
end
