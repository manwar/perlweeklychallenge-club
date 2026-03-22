#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 365 Task 1: Alphabet Index Digit Sum
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub alphabet_index_digit_sum( $str, $k ) {
    my $sum_string = join "", map ord( $_ ) - ord( "a" ) + 1, split "", $str;
    $sum_string = sum( split "", $sum_string )
        while length( $sum_string ) > 1 && $k-- > 0;
    return $sum_string;
}

use Test2::V0 qw( -no_srand );

is alphabet_index_digit_sum( "abc", 1 ), 6,
    'Example 1: alphabet_index_digit_sum( "abc", 1 ) == 6';
is alphabet_index_digit_sum( "az", 2 ), 9,
    'Example 2: alphabet_index_digit_sum( "az", 2 ) == 9';
is alphabet_index_digit_sum( "cat", 1 ), 6,
    'Example 3: alphabet_index_digit_sum( "cat", 1 ) == 6';
is alphabet_index_digit_sum( "dog", 2 ), 8,
    'Example 4: alphabet_index_digit_sum( "dog", 2 ) == 8';
is alphabet_index_digit_sum( "perl", 3 ), 6,
    'Example 5: alphabet_index_digit_sum( "perl", 3 ) == 6';

is alphabet_index_digit_sum( "veeeeeeeeerylongstring", 0 ),
    "22555555555182512151471920189147",
    'Own test 1: no overflow for a very long string ($k=0)';
is alphabet_index_digit_sum( "veeeeeeeeerylongstring", 3 ),
    2,
    'Own test 2: no overflow for a very long string ($k=3)';

done_testing;
