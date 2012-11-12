log = (html) ->
  document.getElementById("log").innerHTML = html
onSuccess = ->
  log "success"
onError = ->
  log "error"
onProgress = (loaded, total) ->
  log loaded + " / " + total




form = document.forms.upload
form.onsubmit = ->  
  file = @elements.photo.files[0]
  upload file, onSuccess, onError, onProgress  if file
  false


token = document.forms.upload.elements["authenticity_token"]
book_id = document.getElementById("book_id")
user_id = document.getElementById("user_id")
if book_id != null
  path = "/books/#{book_id.value}/photos"
else
  path = "/users/#{user_id.value}/photos"

upload = (file, onSuccess, onError, onProgress) ->
  xhr = new XMLHttpRequest()
  xhr.onload = xhr.onerror = ->
    unless @status is 200
      onError this
      return
    onSuccess()
    if book_id != null
      window.location = "/books/" + book_id.value
    else   
      window.location = "/users/#{user_id.value}"
  
  xhr.upload.onprogress = (event) ->
    $(document).ready -> 
      $bar = $(".bar")
      pc = (parseInt (event.loaded*400 / event.total))
      $bar.width $bar.width() + pc
      #$bar.text  parseInt ((event.loaded*100)/event.total + 1 )  
      onProgress event.loaded, event.total
      
 
  xhr.open "POST", path, true
  formData = new FormData()
  formData.append "authenticity_token", token.value
  if book_id != null
    formData.append "book_id", book_id.value
  formData.append "photo", file
  xhr.send formData