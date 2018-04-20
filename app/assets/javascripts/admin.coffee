# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@setrowclass = (variable) ->
  num = parseFloat(variable,10)
  if num == 100
    return "table-success"
  else if num > 85 && num < 100
    return "table-warning"
  else if num > 50 && num <= 85  
    return "table-middle"
  else if num > 0 && num <= 50 
    return "table-danger"
  else
    return ""
$ ->
  $('#schools-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#schools-table').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'ministry_code'}
      {data: 'school_name'}
      {data: 'percent_all'}
      {data: 'percent_1',searchable: false}
      {data: 'percent_2',searchable: false}
      {data: 'percent_3',searchable: false}
      {data: 'percent_4',searchable: false}
      {data: 'userinscool',searchable: false}
    ]
    order: [[ 2, "desc" ]] 
    createdRow:  (row, data, index) ->
        #console.log(data)
        rowclass = setrowclass(data.percent_all)
        cellclass1 = setrowclass(data.percent_1)
        cellclass2 = setrowclass(data.percent_2)
        cellclass3 = setrowclass(data.percent_3)
        cellclass4 = setrowclass(data.percent_4)
        $(row).addClass(rowclass)
        $("td:eq(2)",row).addClass(rowclass)
        $("td:eq(3)",row).addClass(cellclass1)
        $("td:eq(4)",row).addClass(cellclass2)
        $("td:eq(5)",row).addClass(cellclass3)
        $("td:eq(6)",row).addClass(cellclass4)

    
    