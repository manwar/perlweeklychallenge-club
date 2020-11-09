#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: The weekly challenge #085
#  				https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/
#  				Task 2 - Power of two integers
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;

sub is_power_two_integers {
	my $what = shift;

    return 0 if $what == 1;

    # loop from 2 to int(sqrt) and check if the number can be represent as
    # power of the loop variable
    
    for my $i (2..int(sqrt($what))) {
        print "$i\n";
        # I had to do this as log($what)/log($i) == int(the same) did not work,
        # although print of that number showed it was int (without decimal digits)...
        return 1 if log($what)/log($i) - int(log($what)/log($i)) < 0.00000000001;
    }

	return 0;
}

use Test::More;

is(is_power_two_integers(8), 1);
is(is_power_two_integers(15), 0);
is(is_power_two_integers(125), 1);
is(is_power_two_integers(625), 1);
done_testing;



