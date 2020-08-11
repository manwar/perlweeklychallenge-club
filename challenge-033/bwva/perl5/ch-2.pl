#!/usr/bin/perl

use strict;
use warnings;

my @factors	= (1..11);
my $pat	= "%4s";

printf $pat . '|',  'x';
print map( { sprintf $pat => $_ } @factors), "\n";
print '----+', '----' x @factors, "\n";
for my $step (@factors) {
	printf $pat . '|',  $step;
	for my $num (@factors) {
		printf $pat,  $step > $num ? "" : $step * $num;
	}
	print "\n";
}