// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
// require bootstrap
// require bootstrap-select
// require cocoon
//= require rails.validations
//= require rails.validations.simple_form
//= require select2-full
//= require jquery.dataTables
// require loading_screen
//= require_tree .
var unsaved = false;
$(document).on("page:fetch", function(){
  $(".spinner").show();
});

$(document).on("page:receive", function(){
  $(".spinner").hide();
});
$(document).on("ajax:success", function() {
    $("#exportexceladmin").removeAttr('data-disable-with');
});
$(function(){
   // hide spinner
   $(".spinner").hide();
   $('.container-insert form').submit(function() {
       $(".spinner").show();
    });

    $(".active-border").each(function(index,elm){
        var per = parseInt($(elm).find(".prec").text(),10)
        //console.log(per)
        showdegree($(elm),per*3.6);
    })
    $(".bar-active-border").each(function(index,elm){
        var per = parseInt($(elm).find(".bar-prec").text(),10)
        //console.log(100-per)
        $(this).find(".bar").css('height',(100-per)+'%')
    })
    $(".alert,.notice-alert" ).fadeOut(3000);
    $(window).scroll(function(){
        if ($(this).scrollTop() > 400) {
            $(".scrollToTop").fadeIn(1000);
            $(".btn-scoll-fixed").addClass("btn-fixed")
        } else {
            $(".scrollToTop").fadeOut(1000);
            $(".btn-scoll-fixed").removeClass("btn-fixed")
        }
    });

    //Click event to scroll to top
    $(".scrollToTop").click(function(){
        $('html, body').animate({scrollTop : 0},500);
        return false;
    });
    $('#user_school_id').select2({
          ajax: {
                url: '/allschools',
                dataType: 'json',
                delay: 250,
                data: function(params) {
                    return {
                        term: params.term,
                        page: params.page,
                        page_limit: 50
                    };
                },
                processResults: function(data, page) {
                    //console.log(data)
                    return {
                        results: data.schools
                    };
                },
                cache: true
            },
            escapeMarkup: function(markup) {
                return markup;
            },
            //allowClear: true,
            //placeholder: "ชื่อสถานศึกษา หรือ รหัสสถานศึกษา*",
            templateResult: function(school) {
                if(typeof school.ministry_code !== "undefined" && typeof school.school_name !== "undefined")
                
                    return school.ministry_code +" "+ school.school_name+" "+ school.district+" "+ school.province
                
                return school.school_name || school.ministry_code;
            },
            templateSelection: function(school) {
                
                if(typeof school.ministry_code !== "undefined" && typeof school.school_name !== "undefined")
                
                    return school.ministry_code +" "+ school.school_name+" "+ school.district+" "+ school.province
                
               return "ชื่อสถานศึกษา หรือ รหัสสถานศึกษา*"
            }
        });
      $(".addNewOtherMusic").click(function(){
          $(this).closest(".notice").find(".musicOtherSet").append($(this).closest(".notice").find(".new_music_form").html())
      })

      // Another way to bind the event
        $(window).bind('beforeunload', function(event) {
            if(unsaved){
                return "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
            }
        });
        
     $("#exportexceladmin,#exportexceladmin2,#exportexceladmin3").removeAttr('data-disable-with');
       
})
function setOtherShowHideStatus(val,elm){
    //console.log(val);
    var $otherinput = $(elm).closest(".showoptionstatus").find("input:last");
    if(val == "อื่นๆ (ระบุ)") {
       
      $otherinput.val('');      
      $otherinput.show();
    }else{
      $otherinput.val(val);
      $otherinput.hide();
    }
}
function setOtherShowHideStatusOnly(val,elm){
    //console.log(val);
    var $otherinput = $(elm).parent().find(".showoptionstatus");
    if(val == "ปราชญ์ชาวบ้าน") {
       
      $otherinput.val('');      
      $otherinput.show();
    }else{
      $otherinput.val(val);
      $otherinput.hide();
    }
}
function setOtherShowHide(val,elm){
    //console.log(val);
    var $otherinput = $(elm).parent().find("input:last");
    if(val == "อื่นๆ (โปรดระบุ)") {
       
      $otherinput.val('');      
      $otherinput.show();
    }else{
      $otherinput.val(val);
      $otherinput.hide();
    }
}
function showdegree(elm,i){
	/*if (i<=180){
	    //f4f2f2
        elm.css('background-image','linear-gradient(' + (90+i) + 'deg, transparent 50%, #f4f2f2 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
    }
    else{
        //39B4CC
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #39B4CC 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
    }*/
    if (i<=180){
	    //f4f2f2
        elm.css('background-image','linear-gradient(' + (90+i) + 'deg, transparent 50%, #f4f2f2 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#EE220C')
    }
    else if (i > 180 && i<=306){
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #fd7e14 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#FF9300')
        
    }
    else if (i === 360){
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #28a745 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#1DB100')
        
    }
    else{
        //39B4CC
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #ffc107 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#ffc107')
        
    }
   

}
