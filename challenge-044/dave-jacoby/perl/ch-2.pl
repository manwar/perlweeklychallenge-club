#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental::signatures };

my $instructions = <<'END';

	You have only $1 left at the start of the week. 
	You have been given an opportunity to make it $200. 
	The rule is simple with every move you can either 
	double what you have or add another $1. 
	
	Write a script to help you get $200 with the 
	smallest number of moves.

END

my @x;
push @x, '1';

# We're looking for "smallest number of moves" so what we're
# conceptually thinking of is "breadth-first" and/or
# Dijkstra's Shortest-Path Algorithm.

# https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm

# So, we're going with the simplest possible representation of
# the tree, where we start with 1 and each node being
# 	- 'p', representing "plus 1"
#   - 'd', representing "double"

# we therefore make an array that looks like

# 1
# 1p
# 1d
# 1pp
# 1pd
# 1dp
# 1dd
# 1ppp
# 1ppd
# 1pdp
#...

# except we pop the string we're looking at it and shift
# that string with both "d" and "p" added.

# we have the function that returns what the string means,
# stop when we've hit 200 and don't shift anything when
# we've overshot.

my @array = (1);
for my $i (@array) {
	my $check = decode($i);
	if ( $check == 200 ) {
		say join "\t", $check, $i, scalar @array;
		exit;
	}

	if ( $check > 200 ) {
		next;
	}
	push @array, $i . 'p';
	push @array, $i . 'd';
}

exit;


sub decode ( $sample ) {
	my ( $i, @list ) = split m//, $sample;
	for my $l (@list) {
		$i += 1 if $l eq 'p';
		$i *= 2 if $l eq 'd';
	}
	return $i;
}

__DATA__

200     1ppdddpddd      1251

1		1
	+1 	2
	+1	3
	*2	6
	*2	12
	*2	24
	+1  25
	*2	50
	*2	100
	*2  200