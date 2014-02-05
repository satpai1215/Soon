/********************
COUTNDOWN CREATION FUNCTIONS
 *********************/

function createCountdown(end_date, selector) {
    var dateString = parseDate(end_date);
    //make dateString firefox/IE compatible
    dateString = dateString.replace(/-/g, "/");
    var end_timer = new Date(dateString);
    now = new Date();
    if(end_timer - now > 0) {
        var t = setInterval(function() {updateCountdown(end_timer, selector)} , 1000);
    }

}

//parses date string object returned from rails events#index view
function parseDate(date) {
	var dateStrings = date.split(" ");

	//dateStrings[0] = "2013-01-05", dateStrings[1] = "16:00:00", for example
	return dateStrings[0] + " " + dateStrings [1];
}


//updates countdown timer for upcoming events
function updateCountdown(d, selector) {
    var currentDate = new Date();
    if (d - currentDate <= 0) {
        $(selector).html("Time's Up!");
    }
    else {

        var timeMS = Math.abs(d - currentDate);
        var seconds = Math.round(timeMS/1000);
        var minutes = Math.floor(seconds/60);
        seconds %= 60;
        var hours = Math.floor(minutes/60);
        minutes %= 60;
        var days = Math.floor(hours/24);
        hours %= 24;

        $(selector).html(days + ((days === 1) ? " Day": " Days") + " " + numChecker(hours) + ":" + numChecker(minutes) + ":" + numChecker(seconds));
    }
}

//converts numbers to two digit strings for countdown timer
function numChecker(num) {
    if(num <10){
        return "0" + num;
    }
    return num;
}
/********************
END COUTNDOWN CREATION FUNCTIONS
 *********************/