#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-05
use utf8;     # Week 220 task 2 - Squareful
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use Algorithm::Loops 'NextPermuteNum';
my (@squares);
$squares[0] = 0;

squareful(1, 17, 8);
squareful(2, 2, 2);
squareful(63, 1, 24, 12, 13, 3, 141, 28, 8, 1, 3);
squareful(1, 2, 3, 4, 5, 6, 7, 8, 9);

sub squareful {
	
	my ($successes, @list, $last, $good, $results, $j);
	
	# initialise
	$results = '';
	@list = sort { $a <=> $b } @_;
	$last = scalar @list - 2;
	
	# loop over permutations, testing for squarefulness
	do {
		$good = 1;
		for $j (0 .. $last) {
			
			# abandon this perm if a pair isn't a square
			unless (is_a_square($list[$j] + $list[$j + 1])) {
				$good = 0;
				last;
			}
		}
		if ($good) {
			$results .= '(' . join(', ', @list) . '), ';
		}
	} while (NextPermuteNum(@list));
	$results = 'No squareful permutation  ' unless $results;
	
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	say qq[Output: ] . substr($results, 0, -2);
}

sub is_a_square {
	
	my ($test, $last_square, $next_number);
	
	$test = $_[0];
	
	# extend (if necessary) list of squares up to at least $test
	# eg $test[9] == 3
	while (1) {
		$last_square = scalar @squares - 1;
		last if $last_square >= $test;
		
		# need more
		$next_number = $squares[$last_square] + 1;
		$squares[$next_number ** 2] = $next_number;
	}
	return defined $squares[$test] ? 1 : 0;
}	
