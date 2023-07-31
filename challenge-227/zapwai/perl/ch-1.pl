use v5.30;
my $year = 2023;	    # between 1753 (begins on monday) and 9999
my $str;
say "Input: \$year = $year";
say "Output: " . fri_13_count($year);
say $str;

sub fri_13_count {
    my $year = shift;
    return check_each_month(start_day($year), is_leap($year));
}

sub is_leap {
    my $year = shift;
    my $ans = 0;
    unless ( $year % 100 == 0 ) {
	$ans = 1 if ( $year % 4 == 0 );
    }
    $ans = 1 if ( $year % 400 == 0 );
    return $ans;
}

sub start_day {
    my $year = shift;
    my $day;
    my @day = ('M', 'T', 'W', 'H', 'F', 'S', 'N');
    # Move ahead one day each year (two after a leap year)
    my $steps = ($year - 1753) % 400;
    my $cnt = 0;
    unless ($steps == 0) {
	for my $i (1 .. $steps) {
	    $cnt = ($cnt + 1) % 7;
	    $cnt = ($cnt + 1) % 7 if (is_leap(-1 + $year + $i - $steps));
	}
    }
    $day = $day[$cnt];
    return $day;
}

sub check_each_month {
    my ($start_day, $leap) = @_;
    my @day = ('M', 'T', 'W', 'H', 'F', 'S', 'N');    
    my @gap = (12, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30);
    $gap[1]++ if ($leap);
    my $number_of_fri13 = 0;
    my $cnt = 0;    # day of the week, convoluted for readability, heh
    for (0 .. $#day) {
	$cnt = $_ if ($day[$_] eq $start_day);
    }
    # start_day is jan 1. We add 12 days to check jan 13. (month i = 0)
    # add 31 days to check Feb 13. (month i = 1)
    # Add 28 (or 29 if $leap == 1) to check Mar 13. etc.

    for my $i (0 .. 11) {
	$cnt = ($cnt + $gap[$i]) % 7;
	my $day = $day[$cnt];	
	if ($day eq 'F') {
	    $number_of_fri13++;
	    $str .= $i+1 ."-13-$year is a Friday.\n";
	}
    }
    return $number_of_fri13;
}
