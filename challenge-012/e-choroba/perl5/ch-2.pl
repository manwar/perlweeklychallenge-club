#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ first };

my @paths = qw(
    /a/b/c/d
    /a/b/cd
    /a/b/cc
    /a/b/c/d/e
);

my @p1 = split m{/}, $paths[0];
my $min = @p1;
for my $i (1 .. $#paths) {
    my @p2 = split m{/}, $paths[$i];
    my $max = (@p1 < @p2) ? $#p1 : $#p2;
    my $diff = first { $p1[$_] ne $p2[$_] } 0 .. $max;
    $diff //= $max + 1;
    $min = $diff if $diff < $min;
}

say join '/', (split m{/}, $paths[0])[0 .. $min - 1];
