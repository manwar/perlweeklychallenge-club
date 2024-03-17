use v5.38;
sub is_leap_year($year) {
    if ($year % 400 == 0) {
	return 1;
    } elsif ($year % 100 == 0) {
	return 0;
    } elsif ($year % 4 == 0) {
	return 1;
    } else {
	return 0;
    }
}

# Given number of days that have passed, provides a date. e.g. 0 -> 1-1-2024
sub days_to_date($days, $year) {
    return "erroneous number of days\n" if ($days++ > 365);
    my @d = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    $d[1]++ if is_leap_year($year);
    my $month = 0;
    $days -= $d[$month++] while ($days > $d[$month]);
    $month = "0$month" if ($month++ < 9);
    return "$month-$days-$year";
}

# print the last friday of each month in a given year.
sub fridays($year) {
    my @day = qw( sat sun mon tue wed thu fri );
    my $base_year = 2000;	# starts on a saturday
    my $skip_days = $year - $base_year;
    foreach ($base_year .. $year - 1) {
	$skip_days++ if is_leap_year($_);
    }
    my $first_day_of_year = $day[$skip_days%7];
    my $first_fri_delta = 0;   # days until the first friday
    $first_fri_delta++ while ($day[($skip_days + $first_fri_delta)%7] ne 'fri');
    my $n = $first_fri_delta;
    my @last_fridays;
    my $tmp = "01-01-1900";
    while ($n < 365) {
	my $date = days_to_date($n, $year);
	push @last_fridays, $tmp if (substr($tmp, 0, 2) ne substr($date, 0, 2));
	$n += 7;
	$tmp = $date;
    }
    push @last_fridays, $tmp;
    say $_ foreach @last_fridays;
}

fridays(2024);
