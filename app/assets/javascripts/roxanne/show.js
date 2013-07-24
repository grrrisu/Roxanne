$().ready(function(){

  jQuery(top).trigger('initialize:frame');

  // hide roxanne toolbar if mercury toolbar is present in parent window
  if(window.location != window.parent.location){
    $("#roxanne_toolbar").hide();
  } else {
    $("a.add_container").hide();
  }

  $("body").on("click", "a.add_container", function(e){
    e.preventDefault();
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

  $("body").on("hover", "a.add_container", function(e){
    e.preventDefault();
    var id = $(this).attr("data-sibling");
    if(id){
      $("#container_" + id).toggleClass('highlight_content');
    } else {
      $(this).parent(".container_list").toggleClass('highlight_content');
    }
  });

  $("body").on("click", "a.add_container_list", function(e){
    alert("add_container_list");
  });

});
