# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".addteachercount").on "click", ->
    num = parseInt($(this).parent().find("input").val(),10)
    childcount =  $(this).closest(".container-insert").find(".musicOtherSet").children().length
    childcountdb =  $(this).closest(".container-insert").find(".dbTeacherSet").children().length
    #console.log(childcount)
    if !isNaN(num) 
        diff = num - childcountdb - childcount
        if diff > 0
            for i in [0...diff]
                #$find = $(this).closest(".container-insert").find(".new_music_form")
                #$find.find(".indexcount").text(childcountdb - childcount)
                $(this).closest(".container-insert").find(".musicOtherSet").append  $(this).closest(".container-insert").find(".new_music_form").html()
    else
        $(this).parent().find("input").val("")
   
   $(".container-insert input,.container-insert select").on "change", ->
         window.unsaved = true
   $(".container-insert input[type='submit'],.container-insert a.not-binding-unsave").on "click", ->
        window.unsaved = false
        this.preventDefault()