// Always request javascript when sending xhr
$(function() {
  $.ajaxSetup({
    'beforeSend': function(xhr) {
      xhr.setRequestHeader("Accept", "text/javascript");
    }
  });
});

$().ready(function(){

  jQuery(top).trigger('initialize:frame');

  // hide roxanne toolbar if mercury toolbar is present in parent window
  if(window.location != window.parent.location){
    $("#roxanne_toolbar").hide();
  } else {
    $("a.add_container").hide();
  }

  $("a.add_container").live("click", function(){
    var url = "/containers/new"
    if ($(this).attr('data-page')){
      url += '?page_id='  + $(this).attr('data-page') + '&name=' + $(this).attr('data-name');
    } else if($(this).attr('data-parent')){
      url += '?parent_id='  + $(this).attr('data-parent');
    }
    if ($(this).attr('data-sibling')){
      url += '?sibling_id=' + $(this).attr('data-sibling');
    }
    
    Mercury.modal(url, {
      'title': "New Container"
    })
  });

  $("a.add_container").live("hover", function(){
    var id = $(this).attr("data-sibling");
    if(id){
      $("#container_" + id).toggleClass('highlight_content');
    } else {
      $(this).parent(".container_list").toggleClass('highlight_content');
    }
  });

  $("a.add_container_list").live("click", function(){
    alert("add_container_list");
  });

});