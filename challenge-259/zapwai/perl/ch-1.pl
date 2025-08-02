use v5.38;
my $first_year = 2000; # If you change this, change the first day in @day to match jan 1st
my %days_in_month = qw( 01 31 02 28 03 31 04 30 05 31 06 30 07 31 08 31 09 30 10 31 11 30 12 31 );
my @day = qw( sat sun mon tue wed thu fri );

sub is_leap_year ($year) { return ($year % 400 == 0) ? 1 : ($year % 100 == 0) ? 0 : ($year % 4 == 0) ? 1 : 0; }

# Every year adds one to day of the week (unless there's a leap day, then two)
# The year 2000 started on a saturday -> 2001 starts on a monday.
sub weekday($year, $month, $day) {
    my $skip_days = $year - $first_year;
    for my $yr ($first_year .. $year - 1) {
	$skip_days++ if is_leap_year($yr);
    }
    $skip_days++ if (is_leap_year($year) and $month gt "02");
    for my $m (qw (01 02 03 04 05 06 07 08 09 10 11 12)) {
	$skip_days += $days_in_month{$m} if ($m lt $month);
    }
    $skip_days += $day - 1;
    return $day[$skip_days % 7];
}

sub is_weekend ($year, $month, $day) {
    my $weekday = weekday($year, $month, $day);
    return ( $weekday eq "sat" or $weekday eq "sun" ) ? 1 : 0;
}

sub is_holiday ($bank_holidays, $year, $month, $day) {
    for my $date (@$bank_holidays) {
	my ($yr, $mn, $dy) = split "-", $date;
	return 1 if (
	    ($yr eq $year) and
	    ($mn eq $month) and
	    ($dy eq $day)	);
    }
    0
}

sub proc ($start_date, $offset, $bank_holidays) {
    my ($year, $month, $day) = split "-", $start_date;
    my ($new_year, $new_month, $new_day) = ($year, $month, $day);
    my $steps = $offset;
    while ($steps > 0) {
	my $leap = (is_leap_year($new_year) && ($new_month eq "02")) ? 1 : 0;
	if ($new_day + 1 > $days_in_month{$new_month} + $leap) {
	    if ($new_month eq "12") {
		$new_year++;
	    }
	    $new_month++;
	    $new_month = "01" if ($new_month eq "13");
	    $new_day = "01";
	} else {
	    $new_day = sprintf("%02d", $new_day + 1);
	}
	$steps-- unless (is_holiday($bank_holidays, $new_year, $new_month, $new_day) or is_weekend($new_year, $new_month, $new_day));
    }
    say "Input: $start_date, offset: $offset, holidays: @{$bank_holidays}";
    say "Output: $new_year-$new_month-$new_day";
}

my $start_date = '2018-06-28';
my $offset = 3;
my $bank_holidays = ['2018-07-03'];

proc($start_date, $offset, $bank_holidays);
