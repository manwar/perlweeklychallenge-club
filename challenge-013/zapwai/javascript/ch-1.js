function is_leap_year (year) {
    if (year % 400 == 0)
	return true;
    if (year % 100 == 0)
	return false;
    if (year % 4  == 0)
	return true;
    return false;
}

function days_to_date(days, year) {
    if (days > 365)
	return "erroneous number of days";
    days += 1;
    let d = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (is_leap_year(year))
	d[1] += 1;
    let month = 0;
    while (days > d[month]) {
	days -= d[month];
	month += 1;    
    }
    month += 1;    
    if (month < 10)
	month = "0"+month;
    if (days < 10)
	days = "0"+days;
    return month+'-'+days+'-'+year;
}

function fridays(year) {
    let day = [ "sat", "sun", "mon", "tue", "wed", "thu", "fri" ];
    let base_year = 2000;
    let skip_days = year - base_year;
    for (let yr = base_year; yr < year - 1; yr++)
	if (is_leap_year(yr))
	    skip_days++;
    let first_day_of_year = day[skip_days%7];
    let first_fri_delta = 0;
    while (day[(skip_days + first_fri_delta)%7] != 'fri')
	first_fri_delta++;
    let n = first_fri_delta;
    let last_fridays = [];
    let tmp = "01-01-1900";
    while (n < 365) {
	let date = days_to_date(n, year);
	if (tmp.substring(0, 2) != date.substring(0, 2))
	    last_fridays.push(tmp);
	n += 7;
	tmp = date;
    }
    last_fridays.push(tmp);
    for (let k of last_fridays)
	console.log(k);
}

fridays(2024);
