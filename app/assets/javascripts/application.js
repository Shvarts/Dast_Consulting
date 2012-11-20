// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
// azaza= require jquery.jqGrid.min
//= require twitter/bootstrap
//= require_tree .

$(function() {
  $("#locations th a, #locations .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#locations_search input").keyup(function() {
    $.get($("#locations_search").attr("action"), $("#locations_search").serialize(), null, "script");
    return false;
  });
  $("#locations_search_1 input").keyup(function() {
    $.get($("#locations_search_1").attr("action"), $("#locations_search_1").serialize(), null, "script");
    return false;
  });
});

//$(document).ready(function() {
//  GmapsAutoComplete.init();
//  GmapsAutoComplete.autoCompleteInit();
//});
//
//function drawItems(theBounds) {
//    $.get(function(newItemData) {
//        Gmaps4Rails.replace_markers(newItemData);
//    });
//}
//
//jQuery.ajaxSetup({
//  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
//})
//
//jQuery.fn.submitWithAjax = function() {
//  this.submit(function() {
//    $.post(this.action, $(this).serialize(), null, "script");
//    return false;
//  })
//  return this;
//};
//
//$(document).ready(function() {
//  $("#new_review").submitWithAjax();
//})
//
//document.observe("dom:loaded", function() {
// Ajax.Responders.register({
//  onCreate: function(request) {
//   var csrf_meta_tag = $$('meta[name=csrf-token]')[0];
//   if (csrf_meta_tag) {
//    var header = 'X-CSRF-Token',
//      token = csrf_meta_tag.readAttribute('content');
//
//    if (!request.options.requestHeaders) {
//     request.options.requestHeaders = {};
//    }
//    request.options.requestHeaders[header] = token;
//   }
//  }
// });
//});