#!/usr/bin/env perl6

my $d=Date.new(year=>@*ARGS[0]//"2019");

$d+=(12-$d.day-of-week);
my $year=$d.year;
while ($d.year == $year) {
	state $prev=$d;
	$prev=$d;
	$d+=7;
	if ($d.month !== $prev.month ) {
		print $prev.yyyy-mm-dd~"\n";
	}
}
