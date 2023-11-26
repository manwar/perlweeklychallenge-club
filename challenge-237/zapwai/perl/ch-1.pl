use v5.30;
# Given yr, month, week, day (1 (Mon) .. 7 (Sun)), print date
my ($year, $month, $week, $day) = (2024, 4, 3, 2);
#my ($year, $month, $week, $day) = (2025, 10, 2, 4);
#my ($year, $month, $week, $day) = (2026, 8, 5, 3);

my @d = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
$d[1]++ if (is_leap($year));

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
    my @day = ('1', '2', '3', '4', '5', '6', '7');
    my $steps = ($year - 1753) % 400;
    my $cnt = 0;
    unless ($steps == 0) {
	for my $i (1 .. $steps) {
	    $cnt = ($cnt + 1) % 7;
	    $cnt = ($cnt + 1) % 7
		if (is_leap(-1 + $year + $i - $steps));
	}
    }
    return $day[$cnt];
}

sub month_start_day {
    my ($year, $month) = @_;
    my $start = start_day($year) - 1; # 0 to 6
    my $cnt = $month - 1;
    my $n = 0;
    while ($cnt > 0) {
	$cnt--;
	$start += $d[$n];
	$start %= 7;
	$n++;
    }
    return (1 + $start);	
}

my $date = 1;
my $start_day = month_start_day($year, $month);
my $diff = $day - $start_day;
my $n = $week - 1;
$date += $diff;
$date += $n * 7;
$date += 7 if ($diff < 0);
$date = 0 if ($date > $d[$month-1]);
say "Input: (\$year, \$month, \$week, \$day) = ($year, $month, $week, $day)";
say "Output: $date";
if ($date == 0) {
    say "\t(No such date.)";
}
