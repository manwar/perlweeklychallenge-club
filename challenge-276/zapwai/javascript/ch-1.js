let hours = [12, 12, 30, 24, 24];
proc(hours);
hours = [72, 48, 24, 5];
proc(hours);
hours = [12, 18, 24];
proc(hours);

function proc(hours) {
    console.log("Input:", hours);
    let tally = 0;
    for (let i = 0; i < hours.length - 1; i++) {
	for (let j = i + 1; j < hours.length; j++) {
	    let sum = hours[i] + hours[j];
	    if (sum % 24 == 0) {
		tally++;
	    }
	}
    }
    console.log("Output:", tally);
}
