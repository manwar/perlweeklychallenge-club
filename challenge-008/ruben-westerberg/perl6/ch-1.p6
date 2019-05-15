#!/usr/bin/env perl6
my $count =0;
my $number=1;
my @perfect;
until $count == 5 {
	my $sum=0;
	$sum+=$number %% $_ ?? $_!! 0 for 1..^$number;
	($count++, say $number) if $sum == $number;
	$number++;
}
