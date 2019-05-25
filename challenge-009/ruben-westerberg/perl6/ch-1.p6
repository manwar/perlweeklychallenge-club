#!/usr/bin/env perl6
#
#Find the first square number that has at least 5 distinct digits
my $result;
(0..*).map({
	my $sq= $_**2;
	$result=$sq;
	last if ($sq.comb.Bag.keys)>=5;

});
say $result;
