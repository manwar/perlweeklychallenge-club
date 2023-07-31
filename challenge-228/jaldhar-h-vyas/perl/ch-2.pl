#!/usr/bin/perl
use 5.030;
use warnings;

sub min {
    return ( sort { $a <=> $b } @_)[0];
}

my @ints = @ARGV;
my $ops = 0;

while (scalar @ints) {
    if ($ints[0] == min(@ints)) {
        shift @ints;
    } else {
        push @ints, shift @ints;
    }
    $ops++;
}

say $ops;
