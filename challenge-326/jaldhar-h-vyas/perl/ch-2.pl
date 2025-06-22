#!/usr/bin/perl
use 5.038;
use warnings;

my @ints = @ARGV;
my @decompressed;

while (my ($i, $j) = splice @ints, 0, 2) {
    push @decompressed, ($j) x $i;
}

say q{(}, (join q{, }, @decompressed), q{)};
