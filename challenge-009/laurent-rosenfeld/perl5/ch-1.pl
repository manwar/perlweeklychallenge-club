#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

for my $integer (100..1000) {
    my $square = $integer ** 2;
    my @digits = split //, $square;
    my %unique_digits = map {$_ => 1} @digits;
    if (scalar keys %unique_digits >= 5) {
        say "$integer -> $square";
        last;
    }
}
