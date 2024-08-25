#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 283 Task 2: Digit Count Value
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( frequency );
use List::Util qw( all );

sub digit_count_value( @ints ) {
    my %f = frequency( @ints );
    return all { ( $f{$_} // 0 ) == $ints[$_] } 0..$#ints;
}

use Test2::V0 qw( -no_srand );
ok digit_count_value( 1, 2, 1, 0 ),
    'Example 1: digit_count_value( 1, 2, 1, 0 ) is true';
ok ! digit_count_value( 0, 3, 0 ),
    'Example 2: digit_count_value( 0, 3, 0 ) is false';
ok digit_count_value( 2, 0, 2, 0 ),
    'Test 2: digit_count_value( 2, 0, 2, 0 ) is true';
ok digit_count_value( 3, 2, 1, 1, 0, 0, 0 ),
    'Test 3: digit_count_value( 3, 2, 1, 1, 0, 0, 0 ) is true';
ok digit_count_value( 4, 2, 1, 0, 1, 0, 0, 0 ),
    'Test 4: digit_count_value( 4, 2, 1, 0, 1, 0, 0, 0 ) is true';
ok digit_count_value( 5, 2, 1, 0, 0, 1, 0, 0, 0 ),
    'Test 5: digit_count_value( 5, 2, 1, 0, 0, 1, 0, 0, 0 ) is true';
ok digit_count_value( 6, 2, 1, 0, 0, 0, 1, 0, 0, 0 ),
    'Test 6: digit_count_value( 6, 2, 1, 0, 0, 0, 1, 0, 0, 0 ) is true';
done_testing;
