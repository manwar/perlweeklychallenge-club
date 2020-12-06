#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl
#
#  DESCRIPTION: Perl Weekly Challenge 089
#               Task 1
#               GCD Sum
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/04/2020 09:40:19 PM
#===============================================================================

use strict;
use warnings;
use Math::Utils qw/gcd/;
use Math::Combinatorics;

sub get_gcd_sum {
    my $n = shift;

    my $gcd_sum = 0;

    my $combinat = Math::Combinatorics->new(
        count => 2,
        data  => [ 1 .. $n ],
    );
    while ( my @combo = $combinat->next_combination ) {
        $gcd_sum += gcd(@combo);
    }

    return $gcd_sum;
}

use Test::More;

is( get_gcd_sum(3), 3 );
is( get_gcd_sum(4), 7 );

done_testing;
