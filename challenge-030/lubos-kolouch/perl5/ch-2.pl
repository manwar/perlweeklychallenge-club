#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-030/
#
#  Write a script to print all possible series of 3 positive numbers, where in each series at least one of the number is even and sum of the three numbers is always 12. For example, 3,4,5.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 10/20/2019 10:30:56 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

sub is_ok_triple {
    my ( $x, $y, $z ) = @_;

    return 0 unless $x + $y + $z == 12;
    return 0 unless ( $x % 2 == 0 ) or ( $y % 2 == 0 ) or ( $z % 2 == 0 );
    return 1;
}

sub main {
    my $max = 12;

    for my $x ( 1 .. 10 ) {    # max 10+1+1
        for my $y ( 1 .. 10 ) {
            last if ( $x + $y ) >= $max;

            for my $z ( 1 .. 10 ) {
                my $sum = $x + $y + $z;
                last if $sum > $max;

                say "$x $y $z" if is_ok_triple( $x, $y, $z );

            }
        }
    }
}

main;

# TESTS

use Test::More;

is(is_ok_triple(3,4,5),1,'Test 3 4 5');
is(is_ok_triple(3,4,6),0,'Test 3 4 6');

# it seems there is no triple without even number so can't test
# but leave the code in in case the $max changes

done_testing;
