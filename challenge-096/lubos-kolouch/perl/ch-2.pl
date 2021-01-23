#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #096
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-096/
#               Task 2 - Edit Distance
#  
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 01/23/2021 11:20:18 AM
#===============================================================================

use strict;
use warnings;
use List::Util qw/min/;

sub edit_distance {
    my $what = shift;

    # Wagner-Fischer algorithm
    # https://en.wikipedia.org/wiki/Wagner–Fischer_algorithm

    my @d;

    $d[0][0] = 0;
    $d[$_][0] = $_ for (1..length($what->[0]));
    $d[0][$_] = $_ for (1..length($what->[1]));

    for my $j (1..length($what->[1])) {
        for my $i (1..length($what->[0])) {

		
			my $substitutionCost = 0;
			if (substr($what->[0], $i-1, 1) ne substr($what->[1], $j-1, 1)) {
				$substitutionCost = 1;
			}

            $d[$i][$j] = min($d[$i-1][$j] + 1,                   # deletion
                           $d[$i][$j-1] + 1,                   # insertion
                           $d[$i-1][$j-1] + $substitutionCost);  # substitution
		}
	}

    return $d[length($what->[0])][length($what->[1])];

}

use Test::More;

is(edit_distance(['sitting', 'kitten']), 3);
is(edit_distance(['sunday', 'monday']), 2);
done_testing;
