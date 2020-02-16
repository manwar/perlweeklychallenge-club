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
    return int($number);
}

for (my $i = 100; $count < $QUANTITY ; ++$i) {

    $first = firstDigit $i;
    $last  = $i % 10;
    my $formedBy = ($first * 10) + $last;

    if ( $i % $formedBy == 0 ) {
        print "$i ";
        ++$count;
    }
}
print "\n";

__END__
output:
        100 105 108 110 120 121 130 132 135 140 143 150 154 160 165 170 176 180 187 190 
