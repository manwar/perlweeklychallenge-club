#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 223 Task 2: Box Coins
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( max );

sub box_coins {
    my ( @box ) = @_;

    return $box[0]
	if @box == 1;

    return max( map {
	( $box[$_]
	    * ( $_ > 0     ? $box[ $_ - 1 ] : 1 )
	    * ( $_ < $#box ? $box[ $_ + 1 ] : 1 ) )
	+ box_coins( @box[ 0 .. $_ - 1, $_ + 1 .. $#box ] );
    } 0..$#box );
}

run_tests;

__DATA__

Test 1: ( 2, 5 )
Input: @box = ( 2, 5 )
Output: 15
