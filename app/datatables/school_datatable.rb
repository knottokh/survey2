class SchoolDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        school_name: { source: "School.school_name", cond: :like, searchable: true, orderable: true },
        ministry_code:  { source: "School.ministry_code",  cond: :like  },
        students_count:        { source: "School.students_count" , searchable: false, orderable: true},
        percent_1:             { source: "percent_1" , searchable: false, orderable: false},
        percent_2:        { source: "percent_2" , searchable: false, orderable: false},
        percent_3:        { source: "percent_3" , searchable: false, orderable: false},
        percent_4:        { source: "percent_4" , searchable: false, orderable: false},
        percent_all:        { source: "percent_all" , searchable: false, orderable: false},
        userinscool:        { source: "userinscool" , searchable: false, orderable: true},
        district:        { source: "School.district" , searchable: false, orderable: false},
        id:        { source: "School.id" , searchable: false, orderable: false },
      }
  end

  def data
    
    records.map do |record|
      {
        # example:
        school_name:      record.school_name,
        ministry_code:    record.ministry_code,
        students_count:   record.students_count,
        district:   record.district,
        percent_1:        record.percent_1,
        percent_2:    record.percent_2,
        percent_3:   record.percent_3,
        percent_4:      record.percent_4,
        percent_all:    record.percent_all,
        userinscool:   record.userinscool,
        id:   record.id,
      }
    end
  end

  private
  def  get_raw_records
     School.schoolpercent
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
