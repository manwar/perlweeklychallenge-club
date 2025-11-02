#!/usr/bin/perl
use 5.038;
use warnings;

my @ints = @ARGV;
my @peaks;

if ($ints[0] > $ints[1]) {
    push @peaks, 0;
}

for my $i (1 .. scalar @ints - 2) {
    if ($ints[$i - 1] < $ints[$i] > $ints[$i + 1]) {
        push @peaks, $i;
    }
}

if ($ints[-1] > $ints[-2]) {
    push @peaks, $#ints;
}

say  q{(}, (join q{, }, @peaks), q{)};
