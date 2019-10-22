#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';


=Write a script to print all possible series of 3 positive numbers,
 where in each series at least one of the number is even and sum of the three numbers is always 12.
 For example, 3,4,5.
=cut


sub PrintSeries() {
    my $sum = 12;

    for my $i (1 .. $sum) {
        for my $j ($i .. $sum) {
            for my $k ($j .. $sum) {
                if ($i + $j + $k == $sum) {
                    print qq($i $j $k \n);
                }
            }
        }
    }
}

PrintSeries();
