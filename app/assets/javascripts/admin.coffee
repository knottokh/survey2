# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@setrowclass = (variable) ->
  num = parseFloat(variable,10)
  if num == 100
    return "table-success"
  else if num > 85 && num < 100
    return "table-yellow"
  else if num > 50 && num <= 85  
    return "table-warning"
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
      {data: 'percent_all', render: $.fn.dataTable.render.number( ',', '.', 2, '' )}
      {data: 'percent_1',searchable: false, render: $.fn.dataTable.render.number( ',', '.', 2, '' )}
      {data: 'percent_2',searchable: false, render: $.fn.dataTable.render.number( ',', '.', 2, '' )}
      {data: 'percent_3',searchable: false, render: $.fn.dataTable.render.number( ',', '.', 2, '' )}
      {data: 'percent_4',searchable: false, render: $.fn.dataTable.render.number( ',', '.', 2, '' )}
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
        $("td:eq(7)",row).addClass("tdclick").html("<span class='user-click-view'><i class='fa fa-user'></i>"+data.userinscool+"</span>")
           .on "click", -> 
              #alert("click"+data.id)
              $('#exampleModalCenter').modal().find('.modal-body').html("Wating ...")
              $.ajax '/getuserinfo',
              		dataType: 'json'
              		data: {
                      schoolid: data.id
                  }
              		error: (jqXHR, textStatus, errorThrown) ->
              			console("AJAX Error: #{textStatus}")
              		success: (data, textStatus, jqXHR) ->
              			#console.log(data.users)
              			datahtml = $("<ul><u>")
              			for d in data.users
              			    datahtml.append("<li>#{d.prefix}#{d.name}  #{d.surname}  #{d.phone}</li>")
                    if data.users.length == 0
                      datahtml = "ไม่พบผู้ใช้งาน"
                    else
                      datahtml = datahtml.html()
              			$('#exampleModalCenter').find('.modal-body').html(datahtml)
           
    oLanguage: {
       sSearch: "กรอกรหัสหรือชื่อโรงเรียน"
     }
    fnServerParams: (aoData) ->
        #console.log(aoData)
        #aoData.columns[1].search.value = "1010720051,1049730258"
        #var includeUsuallyIgnored = $("#include-checkbox").is(":checked");
        #aoData.push({name: "includeUsuallyIgnored", value: includeUsuallyIgnored});
    

    
    