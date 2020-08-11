#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub collatzSequence {
    my ($n) = @_;
    my @sequence = ($n);

    while ($n != 1) {
        $n = ($n % 2) ? (3 * $n + 1) : ($n / 2);
        push @sequence, $n;
    }

    return @sequence;
}

my $maxlength = 0;
my @longest = ();

for my $n (1 .. 1e6) {
    my $length = scalar collatzSequence($n);

    if ($length >= $maxlength) {
        $maxlength = (scalar @longest) ? $longest[-1]->[1] : $length;
        push @longest, [$n, $length];

        @longest = sort {$b->[1] <=> $a->[1] } @longest;
        if (scalar @longest > 20) {
            pop @longest;
        } 
    }
}

for my $long (@longest) {
    say $long->[0], ': ', $long->[1];
}