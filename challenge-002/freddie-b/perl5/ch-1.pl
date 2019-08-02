#!/usr/bin/perl
use feature 'say';

# Write a script or one-liner to remove leading zeros from positive numbers.
# perl week2_01.pl 01 001.3 002 00005 .7 5 5.005 101 000.1 000010 -3 -003

for my $a (@ARGV) {
    if ($a > 0) {
        say 0 + $a;
    }
}

