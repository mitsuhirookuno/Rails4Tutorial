# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.typeahead').typeahead();

$ ->
  $("#keyword").focus(->
    $(this).removeClass().val ""  if $(this).hasClass("dummy_text")
  ).blur(->
    $(this).addClass("dummy_text").val "検索したいキーワード"  if $(this).val().length is 0
  ).blur()
