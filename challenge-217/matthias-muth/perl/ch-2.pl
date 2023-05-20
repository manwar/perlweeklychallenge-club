#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 217 Task 2: Max Number
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use Data::Dump qw( pp );
use List::Util qw( reduce );

sub max_number {
    my ( @list ) = @_;
    # say "max_number( ", pp( @list ), " )";
    return $list[0]
        if @list == 1;

    my ( $best, $max ) = ( undef, 0 );
    for ( 0..$#list ) {
 my @sub_list = @list;
 splice @sub_list, $_, 1, ();
        my $try = $list[$_] . max_number( @sub_list );
 ( $best, $max ) = ( $_, $try )
     if $try > $max;
    }
    return $max;
}


use lib '.';
use TestExtractor;
run_tests();


__DATA__

Test 1:
Input: @list = ( 53 52 5 4 )
Output: 553524

Test 2:
Input: @list = ( 53 52 5 1 )
Output: 553521

Test 3:
Input: @list = ( 53 52 5 6 )
Output: 655352
