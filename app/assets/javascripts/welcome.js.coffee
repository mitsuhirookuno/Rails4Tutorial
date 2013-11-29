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

# 'http://www.google.com/calendar/feeds/ja.japanese%23holiday%40group.v.calendar.google.com/public/full/'
$(document).ready ->
  $("#calendar").fullCalendar
    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"
    editable: false
    events: events
    titleFormat:
      month: 'yyyy年 M月'
      week: 'yyyy年 M月 dd日'
      day: 'yyyy年 M月 dd日'
    columnFormat:
      week: 'dd日（ddd）'
      day: 'dd日 ddd曜日'
    allDayText: '終日'
    axisFormat: 'HH:mm'
    timeFormat: 'HH:mm'
    monthNames: [
      '１月'
      '２月'
      '３月'
      '４月'
      '５月'
      '６月'
      '７月'
      '８月'
      '９月'
      '１０月'
      '１１月'
      '１２月'
    ]
    dayNamesShort: [
      '日'
      '月'
      '火'
      '水'
      '木'
      '金'
      '土'
    ]
    buttonText:
      today: '今日'
      month: '月'
      week: '週'
      day: '日'
 #   events:
 #     url: 'http://www.google.com/calendar/feeds/ja.japanese%23holiday%40group.v.calendar.google.com/public/full/'

$(".myCarousel").carousel interval: false