#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub backtrack {
    my ($n, $vanEcks) = @_;

    for (my $i = scalar @{$vanEcks} - 1; $i > 0; $i--) {
        if ($vanEcks->[$i - 1] == $n) {
            return scalar @{$vanEcks} - $i;
        }
    }
    return 0;
}

my @vanEcks = (0);
my $n = 0;

while (scalar @vanEcks <= 100) {
    push @vanEcks, $n;
    $n = backtrack($n, \@vanEcks);
}

say join ", ", @vanEcks;
