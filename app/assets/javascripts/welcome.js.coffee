# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.typeahead').typeahead();

$ ->
  $("#keyword").focus(->
    # $(this).removeClass().val ""  if $(this).hasClass("span2 search-query dummy_text")
    $(this).addClass("search-query").val ""  if $(this).hasClass("search-query dummy_text")
  ).blur(->
    $(this).addClass("search-query dummy_text").val "please input!"  if $(this).val().length is 0
  ).blur()
