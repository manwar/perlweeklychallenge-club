#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 225 Task 2: Left Right Sum Diff
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( reductions );
use List::MoreUtils qw( pairwise );

sub left_right_sum_diff {
    my ( @ints ) = @_;
    vsay "left_right_sum_diff( @ints )";

    my @left  = reductions { $a + $b } 0, @ints[ 0 .. $#ints - 1 ];
    my @right = reverse reductions { $a + $b } 0, reverse @ints[ 1 .. $#ints ];
    my @diffs = pairwise { abs( $a - $b ) } @left, @right;

    vsay "    left sum:  @left";
    vsay "    right sum: @right";
    vsay "    diffs:     @diffs";

    return @diffs;
}

run_tests;
