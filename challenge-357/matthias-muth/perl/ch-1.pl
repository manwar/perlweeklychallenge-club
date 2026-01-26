#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 357 Task 1: Kaprekar Constant
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub kaprekar_constant( $int ) {
    my $count = 0;
    while () {
        return $count if $int == 6174;
        return -1 if $int == 0;
        my $n2 = join "", sort split "", sprintf "%04d", $int;
        $int = reverse( $n2 ) - $n2;
        ++$count;
    }
}

use Test2::V0 qw( -no_srand );

is kaprekar_constant( 3524 ), 3,
    'Example 1: kaprekar_constant( 3524 ) == 3';
is kaprekar_constant( 6174 ), 0,
    'Example 2: kaprekar_constant( 6174 ) == 0';
is kaprekar_constant( 9998 ), 5,
    'Example 3: kaprekar_constant( 9998 ) == 5';
is kaprekar_constant( 1001 ), 4,
    'Example 4: kaprekar_constant( 1001 ) == 4';
is kaprekar_constant( 9000 ), 4,
    'Example 5: kaprekar_constant( 9000 ) == 4';
is kaprekar_constant( 1111 ), -1,
    'Example 6: kaprekar_constant( 1111 ) == -1';
is kaprekar_constant( "0009" ), 4,
    'Test 1: kaprekar_constant( "0009" ) == 4';
is kaprekar_constant( "0000" ), -1,
    'Test 1: kaprekar_constant( "0000" ) == -1';

done_testing;
