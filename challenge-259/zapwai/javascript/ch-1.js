let base_year = 2000;
let days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
let days = ["sat", "sun", "mon", "tue", "wed", "thu", "fri"];

function is_leap_year(year) {
    if (year % 400 == 0) {
	return true;
    }
    if (year % 100 == 0) {
	return false;
    }
    if (year % 4 == 0) {
	return true;
    }
    return false;
}

function weekday(year, month, day) {
    let skip_days = year - base_year;
    for (let yr = base_year; yr < year; yr++) {
	if (is_leap_year(yr)) {
	    skip_days++;
	}
    }
    if (is_leap_year(year) && month > 2) {
	skip_days++;
    }
    for (let m = 1; m < 13; m++) {
	if (m < month) {
	    skip_days += days_in_month[m-1];
	}
    }
    skip_days += day - 1;
    return days[skip_days % 7];
}

function is_weekend(year, month, day) {
    let today = weekday(year, month, day);
    if (today == "sat" || today == "sun") {
	return true;
    }
    return false;
}

function is_holiday(bank_holidays, year, month, day) {
    let date = format_date(year, month, day);
    for (let hol in bank_holidays) {
	if (hol == date) {
	    return true;
	}
    }
    return false;
}

function format_date(year, month, day) {
    let yr = year.toString();
    let mn = month.toString().padStart(2,'0');
    let da = day.toString().padStart(2,'0');
    return yr+"-"+mn+"-"+da;
}

function parse_date(date) {
    let year = "";
    let month = "";
    let day = "";
    for (let d of date) {
	if (d == "-") {
	    continue;
	}
	if (year.length < 4) {
	    year += d;
	} else if (month.length < 2) {
	    month += d;
	} else if (day.length < 2) {
	    day += d;
	}
    }
    yr = year;
    mth = month;
    da = day;
    return [yr, mth, da];
}

function proc(start_date, offset, bank_holidays) {
    let result = parse_date(start_date);
    let year = result[0];
    let month = result[1];
    let day = result[2];
    let new_year = year;
    let new_month = month;
    let new_day = day;
    let steps = offset;
    while (steps > 0) {
	let leap = 0;
	if (is_leap_year(new_year) && (new_month == 2)) {
	    leap = 1;
	}
	if (new_day + 1 > days_in_month[new_month - 1] + leap) {
	    if (new_month == 12) {
		new_year++;
	    }
	    new_month++;
	    if (new_month == 13) {
		new_month = 1;
	    }
	    new_day = 1;
	} else {
	    new_day++;
	}
	if (!(is_holiday(bank_holidays, new_year, new_month, new_day)) && !(is_weekend(new_year,new_month,new_day))) {
	    steps--;
	}
    }
    let new_date = format_date(new_year, new_month, new_day);
    console.log("Input:", start_date, "offset:", offset);
    if (bank_holidays.length > 0) {
	for (let h of bank_holidays) {
	    console.log("\tHoliday:",h);
	}
    }
    console.log("Output:", new_date);
}

function mn() {
    let start_date = "2018-06-28";
    let offset = 3;

    let bank_holiday1 = "2018-07-03";
    let bank_holidays = [bank_holiday1];

    proc(start_date, offset, bank_holidays);
}

mn();
