#![allow(non_upper_case_globals)]
const base_year :i32 = 2000;
const days : [&str; 7] = ["sat", "sun", "mon", "tue", "wed", "thu", "fri"];
const days_in_month : [i32; 12] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

fn main() {
    let start_date = "2018-06-28";
    let offset = 3;
    let bank_holiday1 = "2018-07-03";
    let bank_holidays = [bank_holiday1];

    proc(start_date, offset, &bank_holidays);
}

fn is_leap_year(year : i32) -> bool{
    if year % 400 == 0 {
	return true;
    }
    if year % 100 == 0 {
	return false;
    }
    if year % 4 == 0 {
	return true;
    }
    return false;
}

fn weekday(year : i32, month : i32, day : i32) -> String {
    let mut skip_days : i32 = year - base_year;
    for yr in base_year .. year {
	if is_leap_year(yr) { skip_days += 1; }
    }
    if is_leap_year(year) && month > 2 { skip_days += 1; }
    for m in 1 ..= 13 {
	if m < month {
	    skip_days += days_in_month[(m-1) as usize];
	}
    }
    skip_days += day - 1;
    return String::from(days[(skip_days % 7) as usize]);
}

fn is_weekend(year : i32, month : i32, day : i32) -> bool {
    let today = weekday(year, month, day);
    if today == "sat" || today == "sun" {
	return true;
    }
    return false;
}

fn is_holiday(bank_holidays :&[&str], year : i32, month : i32, day : i32) -> bool {
    let date = format_date(year, month, day);
    for s in bank_holidays {
	if date == s.to_string() {
	    return true;
	}
    }
    return false;
}
    
fn format_date(year : i32, month : i32, day : i32) -> String {
    let s = format!("{}-{:02}-{:02}", year, month, day);
    return String::from(s);
}

fn parse_date(date : &str ) -> [i32; 3] {
    let s = String::from(date);
    let yr = &s[0 .. 4];
    let mn = &s[5 .. 7];
    let da = &s[8 .. 10];
    return [yr.parse::<i32>().unwrap(), mn.parse::<i32>().unwrap(), da.parse::<i32>().unwrap()];
}

fn proc(start_date : &str, offset : i32, bank_holidays : &[&str]) {
    let result = parse_date(start_date);
    let year = result[0];
    let month = result[1];
    let day = result[2];
    let mut new_year = year;
    let mut new_month = month;
    let mut new_day = day;
    let mut steps = offset;
    while steps > 0 {
	let mut leap = 0;
	if is_leap_year(new_year) && new_month == 2 {
	    leap = 1;
	}
	if new_day + 1 > days_in_month[(new_month - 1) as usize] + leap {
	    if new_month == 12 {
		new_year += 1;
	    }
	    new_month += 1;
	    if new_month == 13 {
		new_month = 1;
	    }
	    new_day = 1;
	} else {
	    new_day += 1;
	}
	if !is_holiday(bank_holidays, new_year, new_month, new_day) && !is_weekend(new_year, new_month, new_day) {
	    steps -= 1;
	}
    }

    let new_date = format_date(new_year, new_month, new_day);
    print!("Input: start: {start_date}, offset: {offset}, holidays: ");
    for d in bank_holidays {
	print!("{d} ");
    }
    println!("\nOutput: {new_date}");
}
