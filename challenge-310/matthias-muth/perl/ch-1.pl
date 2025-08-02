#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 310 Task 1: Arrays Intersection
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Set::Intersection;
use List::Util qw( all );
use List::MoreUtils qw( frequency );

# CPAN.
sub arrays_intersection_cpan( $list ) {
    return sort { $a <=> $b } get_intersection( $list->@* );
}

# Core only.
sub arrays_intersection( $list ) {
    my @sets = map {
	{ map { ( $_ => 1 ) } $_->@* }
    } $list->@*;
    return sort { $a <=> $b } grep {
	my $candidate = $_;
	all { $sets[$_]{$candidate} } 1..$#sets;
    } keys $sets[0]->%*;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ arrays_intersection( [[1 .. 4], [4, 5, 6, 1], [4, 2, 1, 3]] ) ], [ 1, 4 ],
    'Example 1: arrays_intersection( [[1 .. 4], [4, 5, 6, 1], [4, 2, 1, 3]] ) == (1, 4)';
is [ arrays_intersection( [[1, 0, 2, 3], [2, 4, 5]] ) ], [ 2 ],
    'Example 2: arrays_intersection( [[1, 0, 2, 3], [2, 4, 5]] ) == 2';
is [ arrays_intersection( [[1, 2, 3], [4, 5], [6]] ) ], [  ],
    'Example 3: arrays_intersection( [[1, 2, 3], [4, 5], [6]] ) == ()';

done_testing;
