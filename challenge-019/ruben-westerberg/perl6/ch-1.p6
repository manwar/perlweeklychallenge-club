#!/usr/bin/env perl6

my $s=Date.new("1900-01-01");
my $e=Date.new("2019-01-01");
my @names=<January Febuary March April May June 
		July August September October November December>;
for $s..^$e {
	put .year~" @names[.month-1]"
	if all(.day-of-month == 1, .day-of-week == 5, .days-in-month == 31);
}
