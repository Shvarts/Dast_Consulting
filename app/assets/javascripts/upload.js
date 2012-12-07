var log, onError, onProgress, onSuccess, token, upload;

log = function(html) {
    return document.getElementById("log").innerHTML = html;
};

onSuccess = function() {
    log("success");
    return $(document).ready(function() {
        var $bar;
        $bar = $(".bar");
        $bar.width("100%").text("Success");
        return $('input[type="submit"]').removeAttr("disabled");
    });
};

onError = function() {
    log("error");
    $('.progress').addClass('progress-danger');
    $('.bar').text("Error. Unsupported format or broken file").width('100%');
    return $('input[type="submit"]').removeAttr("disabled");
};

onProgress = function(loaded, total) {
    return log(loaded + " / " + total);
};

token = "";

$(document).ready(function() {
    return token = $('input[name="authenticity_token"]').val();
});

$(document).ready(function() {
    $("#excel_file").unbind().change(function() {
        var file;
        $('.progress').fadeIn("slow");
        $('input[type="submit"]').attr("disabled", "disabled");
        file = $("#excel_file").get(0).files[0];
        if (file) {
            upload(file, onSuccess, onError, onProgress);
        }
        return false;
    });
    return $("#excel_file").click(function() {
        return $(".bar").width(0).text("");
    });
});

upload = function(file, onSuccess, onError, onProgress) {
    var formData, xhr;
    xhr = new XMLHttpRequest();
    xhr.onload = xhr.onerror = function() {
        if (this.status !== 200) {
            onError(this);
            return;
        }
        return onSuccess();
    };
    xhr.upload.onprogress = function(event) {
        return $(document).ready(function() {
            var $bar, pc;
            $bar = $(".bar");
            pc = parseInt(event.loaded / event.total * 100, 10);
            $('.bar').css('width', pc + '%');
            $('.bar').text("Proccessingdump_excel_file...");
            return onProgress(event.loaded, event.total);
        });
    };
    xhr.open("POST", "/locations", true);
    formData = new FormData();
    formData.append("authenticity_token", token);
    formData.append("excel_file", file);
    return xhr.send(formData);
};
