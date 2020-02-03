#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my $MAX = 500;

my @doors = (0) x $MAX;  # All closed.
for my $employee (0 .. $MAX - 1) {
    $doors[$_] = ! $doors[$_]
        for grep 0 == (1 + $_) % (1 + $employee), 0 .. $MAX - 1;
}
say join ' ', map 1 + $_, grep $doors[$_], 0 .. $MAX;
