#!/usr/bin/perl
use 5.36.0;
use strict;

use subs qw/
	simple_method
	my_method
/;

my @m = ([0, 1, 2], [3, 4, 5], [6, 7, 8]);
# say simple_method @m;
say my_method @m;

sub simple_method
{
	(sort { $a <=> $b } map { @$_ } @_)[2]
}

sub my_method
{
	my @m = @_;
	my @small;
	for (my $i = 0; $i <= $#m; $i++) {
		for (my $j = 0; $j <= $#m; $j++) {
			@small = sort { $a <=> $b } (@small, $m[$i][$j]);
			pop @small unless $#small <= 2;
		}
	}

	pop @small
}
