#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 284 Task 1: Lucky Integer
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( frequency );
use List::Util qw( max );

sub lucky_integer( @ints ) {
    my %freq = frequency( @ints );
    return max( grep $freq{$_} == $_, keys %freq ) // -1;
}

use Test2::V0 qw( -no_srand );
is lucky_integer( 2, 2, 3, 4 ), 2,
    'Example 1: lucky_integer( 2, 2, 3, 4 ) == 2';
is lucky_integer( 1, 2, 2, 3, 3, 3 ), 3,
    'Example 2: lucky_integer( 1, 2, 2, 3, 3, 3 ) == 3';
is lucky_integer( 1, 1, 1, 3 ), -1,
    'Example 3: lucky_integer( 1, 1, 1, 3 ) == -1';
done_testing;
