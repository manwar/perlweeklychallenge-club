#!/usr/bin/env perl6
my $t=DateTime.new(:2019year);
my %months;
my @names= <January February March April May June July August September October November December>;
while $t.year == 2019 {
	$t+=Duration.new(60*60*24);;
	%months{@names[$t.month-1]}++ if $t.day-of-week == any (1..5);
}
for  @names {
	put "$_: %months{$_} week days"
}
