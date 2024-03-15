fn is_leap_year (year :i32) -> bool {
    if year % 400 == 0 {
	return true;
    }
    if year % 100 == 0 {
	return false;
    }
    if year % 4  == 0 {
	return true;
    }
    return false;
}

fn days_to_date(mut days :i32, year :i32) -> String {
    if days > 365 {
	return "erroneous number of days\n".to_string();
    }
    days += 1;
    let mut d = vec![31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if is_leap_year(year) {
	d[1] += 1;
    }
    let mut month = 0;
    while days > d[month] {
	days -= d[month];
	month += 1;    
    }
    month += 1;
    return format!("{:02}-{:02}-{}", month, days, year);
}

fn fridays(year :i32) {
    let day = vec![ "sat", "sun", "mon", "tue", "wed", "thu", "fri" ];
    let base_year = 2000;
    let mut skip_days = year - base_year;
    for yr in base_year .. year {
	if is_leap_year(yr) {
	    skip_days += 1;
	}
    }
    let mut first_fri_delta = 0;
    while "fri" != day[((skip_days + first_fri_delta)%7) as usize] {
	first_fri_delta += 1;
    }
    let mut n = first_fri_delta;
    let mut last_fridays :Vec<String> = Vec::new();
    let mut tmp = String::from("01-01-1900");
    while n < 365 {
	let date = days_to_date(n, year).to_string();
	if &tmp[0..2] != &date[0..2] {
	    last_fridays.push(tmp);
	}
	n += 7;
	tmp = date;
    }
    last_fridays.push(tmp);
    for w in last_fridays {
	println!("{w}");
    }
}

fn main() {
    fridays(2024);
}
