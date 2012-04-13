// redirect to page without editor when we save the page
$(window).bind('mercury:saved', function() {
  window.location = window.location.href.replace(/\/editor/i, '');
});

$(".image_library img").live("click", function(){
  var attrs = {src: $(this).attr('src').replace('thumb', 'original')}
  //attrs['align'] = alignment if alignment = @element.find('#media_image_alignment').val()
  Mercury.trigger('action', {action: 'insertImage', value: attrs})
  Mercury.modal.hide();
})

$("form#new_container, form#new_container_list").live('submit', function(){
  $.ajax({
    url: $(this).attr("action") + ".js",
    type: $(this).attr("method"),
    data: $(this).serialize(),
    dataType: 'html',
    success: function(data, status, xhr) {
      var sibling_id = $("#container_sibling_id").attr('value')
      var parent_id  = $("#container_parent_id").attr('value')
      var link_id    = sibling_id ? sibling_id : parent_id
      if(link_id){
        var element    = $("#mercury_iframe").contents().find("a#before_"+ link_id);
        element.before(data);
      } else {
        var name       = $("#container_list_name").attr('value');
        var element    = $("#mercury_iframe").contents().find("a#before_"+ name).parent();
        element.replaceWith(data);
      }
      
      Mercury.trigger('reinitialize')
      Mercury.modal.hide()
      // has no effect
      $("#mercury_iframe").contents().find('a#before_' + link_id).prev('.mercury-region').focus()
    },
    error: function(xhr, status, error) {
      alert('Status: ' + status +' Error:'+ error)
    }
  });
  return false
})