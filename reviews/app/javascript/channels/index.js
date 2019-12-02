// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$(document).on("turbolinks:load", function() {
    // Function to handle when searching, handle cases for Current Location/Specific Location
    $("#search_form").submit(() => {
        const find = $("#sb_find").val();
        const near = $("#sb_near").val();
        let search = "?near=" + near;
        search += "&find=" + find;
        if (near === "Current Location") {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    search += "&lat=" + latitude;
                    search += "&long=" + longitude;
                    window.location.search = search; 
                });
                return false;
            }
            else {
                alert("Please Enable Current Loaction");
                return false
            }
        }
        window.location.search = search
        return false;
    });

    // If there are cards, scroll to them
    if ($("#cards").length === 1) {
        $([document.documentElement, document.body]).animate({
            scrollTop: $("#cards").offset().top - 50 
        }, 1000);
    }

    $(".our-card").mouseenter(function() {
        $(this).css("box-shadow", "5px 5px 20px #888888");
    });

    $(".our-card").mouseleave(function() {
        $(this).css("box-shadow", "5px 5px 10px #888888");
    });
});