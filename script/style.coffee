@headerHeight = 38;
@sidebarWidth = 300;

$ ->
  mainHeight = $(window).height() - headerHeight
  $("#main-container").css("height", mainHeight)
  $("#sidebar").css("height", mainHeight)

