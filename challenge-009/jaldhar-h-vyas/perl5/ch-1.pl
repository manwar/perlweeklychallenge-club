#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my $n = 100; # first number with a 5-digit square
while(1) {
    my $nsquared = $n * $n;
    my %digits;
    map { $digits{$_} = 1; } (split //, $nsquared);
    if (scalar keys %digits  == 5) { 
        say "$nsquared ($n * $n)";
        last;
    }
    $n++;
};
