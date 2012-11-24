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
//= require jquery.remotipart
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


$(function() {
  var address_w, alt_parcel_number_w, bedrooms_w, bid_for_export, content_width, created_at_w, delete_row_id, description_w, for_highlight, for_save, full_baths_w, gross_assessed_value_w, gross_improvement_value_w, gross_land_value_w, half_baths_w, improvement_type_w, koef, latitude_w, longitude_w, name2_w, name_w, neighborhood_name_w, owner_email_w, parcel_number_w, property_class_w, property_sub_class_w, tax_year_w, yr_constructed_w, zip_w;
  content_width = parseInt($(".content").css("width"));
  if (content_width < 1100) {
    content_width = 1100;
  }
  koef = 0.12;
  address_w = parseInt(content_width * koef);
  zip_w = parseInt(content_width * koef) - 100;
  created_at_w = parseInt(content_width * koef) - 50;
  latitude_w = parseInt(content_width * koef) - 80;
  longitude_w = parseInt(content_width * koef) - 80;
  owner_email_w = parseInt(content_width * koef);
  description_w = parseInt(content_width * koef);
  parcel_number_w = parseInt(content_width * koef) - 50;
  alt_parcel_number_w = parseInt(content_width * koef);
  name_w = parseInt(content_width * koef);
  name2_w = parseInt(content_width * koef);
  gross_land_value_w = parseInt(content_width * koef) - 30;
  gross_improvement_value_w = parseInt(content_width * koef);
  gross_assessed_value_w = parseInt(content_width * koef);
  neighborhood_name_w = parseInt(content_width * koef);
  property_class_w = parseInt(content_width * koef) - 30;
  property_sub_class_w = parseInt(content_width * koef);
  tax_year_w = parseInt(content_width * koef) - 80;
  yr_constructed_w = parseInt(content_width * koef) - 30;
  full_baths_w = parseInt(content_width * koef) - 80;
  half_baths_w = parseInt(content_width * koef) - 80;
  bedrooms_w = parseInt(content_width * koef) - 80;
  improvement_type_w = parseInt(content_width * koef);
  delete_row_id = 0;
  bid_for_export = null;
  for_save = [];
  for_highlight = [];
  $("#list").jqGrid({
    ignoreCase: true,
    sortorder: "desc",
    sortname: "created_at",
    height: "400px",
    shrinkToFit: false,
    width: content_width,
    url: 'locations',
    datatype: "json",
    colNames: ["Address", "ZIP", "Date", "Latitude", "Longitude", "Owner Email", "Description", "Parcel Number", "Alt Parcel Number", "Name", "Nmae 2", "Gross Land Value", "Gross Improvement Value", "Gross Assessed Value", "Neighborhood Name", "Property Class", "Property Sub Class", "Tax Year", "Yr Constructed", "Full Baths", "Half Baths", "Bedrooms", "Improvement Type"],
    colModel: [
      {
        name: "address",
        index: "address",
        width: address_w,
        editable: true
      }, {
        name: "zip",
        index: "zip",
        width: zip_w,
        editable: true
      }, {
        name: "created_at",
        index: "created_at",
        width: created_at_w
      }, {
        name: "latitude",
        index: "latitude",
        width: latitude_w
      }, {
        name: "longitude",
        index: "longitude",
        width: longitude_w
      }, {
        name: "owner_email",
        index: "owner_email",
        width: owner_email_w
      }, {
        name: "description",
        index: "description",
        width: description_w,
        editable: true
      }, {
        name: "parcel_number",
        index: "parcel_number",
        width: parcel_number_w,
        editable: true
      }, {
        name: "alt_parcel_number",
        index: "alt_parcel_number",
        width: alt_parcel_number_w,
        editable: true
      }, {
        name: "name",
        index: "name",
        width: name_w,
        editable: true
      }, {
        name: "name2",
        index: "name2",
        width: name2_w,
        editable: true
      }, {
        name: "gross_land_value",
        index: "gross_land_value",
        width: gross_land_value_w,
        editable: true
      }, {
        name: "gross_improvement_value",
        index: "gross_improvement_value",
        width: gross_improvement_value_w,
        editable: true
      }, {
        name: "gross_assessed_value",
        index: "gross_assessed_value",
        width: gross_assessed_value_w,
        editable: true
      }, {
        name: "neighborhood_name",
        index: "neighborhood_name",
        width: neighborhood_name_w,
        editable: true
      }, {
        name: "property_class",
        index: "property_class",
        width: property_class_w,
        editable: true
      }, {
        name: "property_sub_class",
        index: "property_sub_class",
        width: property_sub_class_w,
        editable: true
      }, {
        name: "tax_year",
        index: "tax_year",
        width: tax_year_w,
        editable: true
      }, {
        name: "yr_constructed",
        index: "yr_constructed",
        width: yr_constructed_w,
        editable: true
      }, {
        name: "full_baths",
        index: "full_baths",
        width: full_baths_w,
        editable: true
      }, {
        name: "half_baths",
        index: "half_baths",
        width: half_baths_w,
        editable: true
      }, {
        name: "bedrooms",
        index: "bedrooms",
        width: bedrooms_w,
        editable: true
      }, {
        name: "improvement_type",
        index: "improvement_type",
        width: improvement_type_w,
        editable: true
      }
    ],
    rowNum: 50,
    rowList: [5, 10, 20, 50, 100],
    pager: "#pager",
    viewrecords: true,
    loadonce: true,
    caption: "Locations",
    onSelectRow: function(ids) {
      return delete_row_id = ids;
    }
  }).navGrid("#pager", {
    edit: false,
    add: true,
    del: true,
    search: false,
    refresh: true,
    loadui: "enable"
  }, {
    url: '#'
  }, {
    url: '/locations',
    height: 690,
    width: 380,
    reloadAfterSubmit: false,
    mtype: 'POST',
    closeAfterAdd: true,
    afterComplete: function() {
      return $("#list").jqGrid("setGridParam", {
        datatype: 'json'
      }).trigger("reloadGrid");
    }
  }, {
    url: "/locations/delete_record",
    msg: 'Are you sure?\nThis action is irreversable.',
    caption: 'Delete selected Bid',
    mtype: 'POST'
  }, {}, {}).navButtonAdd("#pager", {
    caption: "Show on map",
    buttonicon: "ui-icon-pin-s",
    position: "last",
    title: "",
    cursor: "pointer",
    datatype: "json",
    onClickButton: function() {
      if (delete_row_id !== 0) {
        return window.location.replace("/show_location_on_map/" + delete_row_id);
      } else {
        return alert("Please select a location");
      }
    }
  });
  return $("#list").jqGrid('filterToolbar', {
    searchOnEnter: false,
    defaultSearch: 'cn'
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