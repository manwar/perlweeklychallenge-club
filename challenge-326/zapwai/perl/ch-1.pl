use v5.38;

sub is_leap($yr) {
    if ($yr % 400 == 0) {
	return 1;
    } elsif ($yr % 100 == 0) {
	return 0;
    } elsif ($yr % 4 == 0) {
	return 1;
    } else {
	return 0;
    }
}

sub tally_months($m, $month) {
    my @m = @$m;
    my $total = 0;
    my $end = int($month) - 2;
    for my $i (0 .. $end) {
	$total += $m[$i];
    }
    $total
}

sub proc($date) {
    say "Input: \$date = $date";
    my @m = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    my ($year, $month, $day) = split("-", $date);
    $m[1]++ if (is_leap($year));
    my $cnt = int($day);
    unless($month eq "01") {
	$cnt += tally_months(\@m, $month);
    }
    say "Output: $cnt";
}

my $date = '2025-02-02';
proc($date);
$date = '2025-04-10';
proc($date);
$date = '2025-09-07';
proc($date);
