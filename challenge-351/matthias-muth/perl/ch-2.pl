#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 351 Task 2: Arithmetic Progression
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( all );

sub arithmetic_progression( @num ) {
    @num = sort { $a <=> $b } @num;
    my $diff = $num[1] - $num[0];
    return all { $num[$_] == $num[ $_ - 1 ] + $diff } 2..$#num;
}

use Test2::V0 qw( -no_srand );

is arithmetic_progression( 1, 3, 5, 7, 9 ), T,
    'Example 1: arithmetic_progression( 1, 3, 5, 7, 9 ) is true';
is arithmetic_progression( 9, 1, 7, 5, 3 ), T,
    'Example 2: arithmetic_progression( 9, 1, 7, 5, 3 ) is true';
is arithmetic_progression( 1, 2, 4, 8, 16 ), F,
    'Example 3: arithmetic_progression( 1, 2, 4, 8, 16 ) is false';
is arithmetic_progression( 5, -1, 3, 1, -3 ), T,
    'Example 4: arithmetic_progression( 5, -1, 3, 1, -3 ) is true';
is arithmetic_progression( 1.5, 3, 0, 4.5, 6 ), T,
    'Example 5: arithmetic_progression( 1.5, 3, 0, 4.5, 6 ) is true';

done_testing;
