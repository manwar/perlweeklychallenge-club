#!/usr/bin/env perl

use strict;
use warnings;

# Author: Robert DiCicco
# Date: 01-NOV-2021
# Challenge 137  Lychrel

print("Enter the first number: ");
my $fnum = <STDIN>;
chomp($fnum);

my $found = 0;
my $iterations = 0;
my $snum = 0;

while (( $found == 0) and ($iterations < 500) and ($snum < 10_000_000)) {
    $iterations++;
    $snum = reverse("$fnum");
    my $mysum = $fnum + $snum;
    my $revsum = reverse($mysum);
    $snum =~ s/^\s+//;   #remove leading spaces
    print  "$fnum + $snum = $mysum\n";

    if ( $mysum == $revsum) {
        print("Palindrome found after $iterations iterations\n");
        $found++;
    } else {
        $fnum = $mysum;
    }
}

if ($iterations == 500 ) {
    print("Reached total iteration limit of 500\n");
}

if ($snum >= 10_000_000) {
    print("Value has exceeded limit of 10_000_000\n");
}
