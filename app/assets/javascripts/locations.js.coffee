# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".index_button").click ->
    $.ajax(
      url: "/locations/excel"
      success: update_bar = (data) ->
        $('.bar').css('width', data + '%')
      $('.bar').text("Proccessing...")
      $('.bar').css('width', parseInt(((gon.watch('dynamic_locations_size', interval: 1000, update_bar))/gon.row_size) * 100, 10) + '%')
      gon.watch('dynamic_locations_size', interval: 1000, update_bar)
    )

$(document).ready ->
  $(".index_button").click ->


$ ->
  $("#map_locations_search").submit ->
    valuesToSubmit = $(this).serialize()
    $.ajax(
      url: $(this).attr("action")
      data: valuesToSubmit
      dataType: "script"
    )
#    false


#j = jQuery.noConflict()
$ ->
  content_width = parseInt($(".content").css("width"))
  if content_width < 1100
    content_width = 1100


    #name_w = content_width * 0.3
    #source_w = content_width * 0.5 - 15
    #date_w = content_width * 0.2 - 15

  koef = 0.12

  address_w = parseInt(content_width * koef)
  zip_w = parseInt(content_width * koef)-100
  created_at_w = parseInt(content_width * koef) - 50
  latitude_w = parseInt(content_width * koef) - 80
  longitude_w = parseInt(content_width * koef) - 80
  owner_email_w = parseInt(content_width * koef)
  description_w = parseInt(content_width * koef)
  parcel_number_w = parseInt(content_width * koef) - 50
  alt_parcel_number_w = parseInt(content_width * koef)
  name_w = parseInt(content_width * koef)
  name2_w = parseInt(content_width * koef)
  gross_land_value_w = parseInt(content_width * koef) - 30
  gross_improvement_value_w = parseInt(content_width * koef)
  gross_assessed_value_w = parseInt(content_width * koef)
  neighborhood_name_w = parseInt(content_width * koef)
  property_class_w = parseInt(content_width * koef) - 30
  property_sub_class_w = parseInt(content_width * koef)
  tax_year_w = parseInt(content_width * koef) - 80
  yr_constructed_w = parseInt(content_width * koef) - 30
  full_baths_w = parseInt(content_width * koef) - 80
  half_baths_w = parseInt(content_width * koef) - 80
  bedrooms_w = parseInt(content_width * koef) - 80
  improvement_type_w = parseInt(content_width * koef)


  delete_row_id = 0
  bid_for_export = null

  for_save = []
  #for #list_d
  for_highlight = []

  $("#list").jqGrid(
    ignoreCase: true
    sortorder: "desc"
    sortname: "created_at"
    height: "400px"
    shrinkToFit: false
    width: content_width
    url: 'locations'
    datatype: "json"
    colNames: [ "Address", "ZIP", "Date", "Latitude", "Longitude", "Owner Email", "Description",
                "Parcel Number","Alt Parcel Number", "Name", "Nmae 2", "Gross Land Value", "Gross Improvement Value"
                "Gross Assessed Value", "Neighborhood Name", "Property Class", "Property Sub Class", "Tax Year", "Yr Constructed",
                "Full Baths", "Half Baths", "Bedrooms", "Improvement Type"]
    colModel: [
      name: "address"
      index: "address"
      width: address_w
      editable: true
    ,
      name: "zip"
      index: "zip"
      width: zip_w
      editable: true
    ,
      name: "created_at"
      index: "created_at"
      width: created_at_w
    ,
      name: "latitude"
      index: "latitude"
      width: latitude_w
    ,
      name: "longitude"
      index: "longitude"
      width: longitude_w
    ,
      name: "owner_email"
      index: "owner_email"
      width: owner_email_w
    ,
      name: "description"
      index: "description"
      width: description_w
      editable: true
    ,
      name: "parcel_number"
      index: "parcel_number"
      width: parcel_number_w
      editable: true
    ,
      name: "alt_parcel_number"
      index: "alt_parcel_number"
      width: alt_parcel_number_w
      editable: true
    ,
      name: "name"
      index: "name"
      width: name_w
      editable: true
    ,
      name: "name2"
      index: "name2"
      width: name2_w
      editable: true
    ,
      name: "gross_land_value"
      index: "gross_land_value"
      width: gross_land_value_w
      editable: true
    ,
      name: "gross_improvement_value"
      index: "gross_improvement_value"
      width: gross_improvement_value_w
      editable: true
    ,
      name: "gross_assessed_value"
      index: "gross_assessed_value"
      width: gross_assessed_value_w
      editable: true
    ,
      name: "neighborhood_name"
      index: "neighborhood_name"
      width: neighborhood_name_w
      editable: true
    ,
      name: "property_class"
      index: "property_class"
      width: property_class_w
      editable: true
    ,
      name: "property_sub_class"
      index: "property_sub_class"
      width: property_sub_class_w
      editable: true
    ,
      name: "tax_year"
      index: "tax_year"
      width: tax_year_w
      editable: true
    ,
      name: "yr_constructed"
      index: "yr_constructed"
      width: yr_constructed_w
      editable: true
    ,
      name: "full_baths"
      index: "full_baths"
      width: full_baths_w
      editable: true
    ,
      name: "half_baths"
      index: "half_baths"
      width: half_baths_w
      editable: true
    ,
      name: "bedrooms"
      index: "bedrooms"
      width: bedrooms_w
      editable: true
    ,
      name: "improvement_type"
      index: "improvement_type"
      width: improvement_type_w
      editable: true
    ]
    rowNum: 50
    rowList: [5, 10, 20, 50, 100]
    pager: "#pager"
    viewrecords: true
    loadonce: true
    #  loadui: "dasable"
    caption: "Locations"
    onSelectRow: (ids) ->
      delete_row_id = ids
  ).navGrid "#pager",
    { edit: false, add: true, del: true, search: false, refresh: true, loadui: "enable" }
    { url: '#' } # edit options
    {url: '/locations',
    height:690,
    width: 380,
    reloadAfterSubmit:false,
    mtype: 'POST',
    closeAfterAdd: true,
    afterComplete: ->
      $("#list").jqGrid("setGridParam",
        datatype:'json').trigger("reloadGrid")
#      $("#list").trigger("reloadGrid")
#      $("#list").jqGrid "setGridParam",
#        loadonce: true
    } #  add options
    {url: "/locations/delete_record",  msg: 'Are you sure?\nThis action is irreversable.', caption: 'Delete selected Bid', mtype: 'POST'} # delete options
    {} # search options
    {} # refresh options
  .navButtonAdd "#pager"
    caption:"Show on map"
    buttonicon: "ui-icon-pin-s"
    position: "last"
    title:""
    cursor: "pointer"
    datatype: "json"
    onClickButton: ->
      unless delete_row_id == 0
        window.location.replace("/show_location_on_map/#{delete_row_id}")
      else
        alert("Please select a location")
  #j("#list [id]tr:first").trigger "click"
  $("#list").jqGrid('filterToolbar', { searchOnEnter:false, defaultSearch: 'cn' });

