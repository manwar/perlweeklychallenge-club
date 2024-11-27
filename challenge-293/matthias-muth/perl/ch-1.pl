#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 293 Task 1: Similar Dominos
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::MoreUtils qw( frequency );
use List::Util qw( sum );

sub similar_dominos( $dominos ) {
    my %frequencies = frequency( map { join "-", sort $_->@* } $dominos->@* );
    return sum( grep $_ > 1, values %frequencies );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is similar_dominos( [[1, 3], [3, 1], [2, 4], [6, 8]] ), 2,
    'Example 1: similar_dominos( [[1, 3], [3, 1], [2, 4], [6, 8]] ) == 2';
is similar_dominos( [[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]] ), 3,
    'Example 2: similar_dominos( [[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]] ) == 3';

done_testing;
