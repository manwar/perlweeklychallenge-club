#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/         #
#                                                                         #
# Write a script to print first 20 Gapful Numbers greater than or equal   #
# to 100.                                                                 #
#                                                                         #
# https://oeis.org/A108343                                                #
#                                                                         #
# numbers that are divisible by the number formed by their first and last #
# digit.                                                                  #
#                                                                         #
###########################################################################

use strict;
use warnings;

my $QUANTITY = 20;
my ($first, $last);
my $count = 0;

sub firstDigit {
    my $number = $_[0];
    while ($number >= 10) {
        $number /= 10;
    }
    return $number;
}

for (my $i = 100; $count < $QUANTITY ; ++$i) {

    $first = firstDigit $i;
    $last  = $i % 10;

    if ( $i % $first == 0 && ($last == 0 || $i % $last == 0 )) {
        print "$i ";
        ++$count;
    }
}
print "\n";
