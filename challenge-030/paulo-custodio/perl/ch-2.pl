#!/usr/bin/perl

# Challenge 030
#
# Task #2
# Write a script to print all possible series of 3 positive numbers, where in
# each series at least one of the number is even and sum of the three numbers
# is always 12. For example, 3,4,5.

use Modern::Perl;
use List::Util 'sum';
use List::MoreUtils 'any';

my $sum = shift||12;

for my $i (1..$sum) {
    for my $j ($i+1..$sum) {
        for my $k ($j+1..$sum) {
            if (sum($i, $j, $k) == $sum) {
                if (any {$_%2==0} $i, $j, $k) {
                    say "$i,$j,$k"
                }
            }
        }
    }
}
