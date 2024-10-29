#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-28
use utf8;     # Week 293 - task 1 - Similar dominoes
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

similar_dominoes([6, 8], [1, 3], [3, 1], [2, 4]);
similar_dominoes([10, 12], [12, 10], [33, 34], [34, 33]);
similar_dominoes([6, 8], [1, 3], [4, 1], [2, 4]);

# bigger example
my @d;
for (0 .. 19) {
	push @d, [int(rand(7)), int(rand(7))];
}
similar_dominoes(@d);

sub similar_dominoes {
	
	my ($input, @dominoes, $d, %matches, $some);
	@dominoes = @_;
	$input .= qq{[$_->[0], $_->[1]], } for @dominoes;
	say qq[\nInput:  (] . substr($input, 0, -2) . ')';
	
	# sort each domino to have smallest value first (eg 2, 1 -> 1, 2)
	@dominoes = map ($_->[0] <= $_->[1] ? [$_->[0],  $_->[1]] :  [$_->[1],  $_->[0]], @dominoes);
	
	# gather together ones that match
	for $d (0 .. $#dominoes) {
		$matches{qq[$dominoes[$d]->[0]|$dominoes[$d]->[1]]} .= qq[\$dominoes[$d], ];
	}
	
	# list the ones where >1 match
	$some = 0;
	say qq[Output: Similar Dominoes:];
	for $d (keys %matches) {
		print qq[   ] . substr($matches{$d}, 0, -2) if $matches{$d} =~ m|,.*,|;
		if ($matches{$d} =~ m|(\d+).+?(\d+)|) {
			say qq[ ($dominoes[$1]->[0] and $dominoes[$1]->[1])];
			$some = 1;
		}
	}
	say qq[   None] unless $some;
}
