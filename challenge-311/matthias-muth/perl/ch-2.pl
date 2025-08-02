#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 311 Task 2: Group Digit Sum
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Dsay;
use List::Util qw( sum );

sub group_digit_sum( $str, $int ) {
    while ( length( $str ) > $int ) {
        my @groups = $str =~ /(\d{1,$int})/g;
        $str = join "", map sum( split "", $_ ), @groups;
    }
    return $str;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is group_digit_sum( 111122333, 3 ), 359,
    'Example 1: group_digit_sum( 111122333, 3 ) == 359';
is group_digit_sum( 1222312, 2 ), 76,
    'Example 2: group_digit_sum( 1222312, 2 ) == 76';
is group_digit_sum( 100012121001, 4 ), 162,
    'Example 3: group_digit_sum( 100012121001, 4 ) == 162';

done_testing;
