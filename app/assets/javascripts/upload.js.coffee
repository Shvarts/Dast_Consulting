log = (html) ->
  document.getElementById("log").innerHTML = html
onSuccess = ->
  log "success"
  $(document).ready ->
    $bar = $(".bar")
    $bar.width("100%").text("Success")
    $('input[type="submit"]').removeAttr("disabled")
onError = ->
  log "error"
  $('.progress').addClass('progress-danger')
  $('.bar').text("Error. Unsupported format or broken file").width('100%')
  $('input[type="submit"]').removeAttr("disabled")
onProgress = (loaded, total) ->
  log loaded + " / " + total

token = ""

$(document).ready ->
  token = $('input[name="authenticity_token"]').val()

$(document).ready ->
  $("#excel_file").unbind().change ->
    $('.progress').fadeIn("slow")
    $('input[type="submit"]').attr("disabled","disabled")
    file = $("#excel_file").get(0).files[0]
    upload file, onSuccess, onError, onProgress if file
    false
  $("#excel_file").click ->
    $(".bar").width(0).text("")


upload = (file, onSuccess, onError, onProgress) ->
  xhr = new XMLHttpRequest()
  xhr.onload = xhr.onerror = ->
    unless @status is 200
      onError this
      return
    onSuccess()


  xhr.upload.onprogress = (event) ->
    $(document).ready ->
      $bar = $(".bar")
      pc = parseInt(event.loaded / event.total * 100, 10)
#      $bar.width $bar.width() + "#{pc}%"
      $('.bar').css('width', pc + '%')
      $('.bar').text("Proccessing...")
      onProgress event.loaded, event.total


  xhr.open "POST", "/locations", true
  formData = new FormData()
  formData.append "authenticity_token", token
  formData.append "excel_file", file
  xhr.send formData


