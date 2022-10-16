#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub zip {
	my ( $a, $b ) = @_;

	# Boils down to iterating over elements
	return map { $a->[ $_ ], $b->[ $_ ] } 0 .. ( @$a > @$b ? $#$b : $#$a );
}

my @a = qw/1 2 3/;
my @b = qw/a b c/;

# Testing..
is_deeply [ zip( \@a, \@b ) ], [ qw/1 a 2 b 3 c/ ], "Zipped?";
is_deeply [ zip( \@b, \@a ) ], [ qw/a 1 b 2 c 3/ ], "Zipped?";

done_testing( 2 );
