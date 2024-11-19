#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;

my $maxJumps = $ints[0];
my $step = $ints[0];
my $jumps = 1;

for my $i (1 .. scalar @ints - 2) {
    if ($i + $ints[$i] > $maxJumps) {
        $maxJumps = $i + $ints[$i];
    }
    $step--;

    if ($step == 0) {
        $jumps++;
        if ($i >= $maxJumps) {
            $jumps = -1;
            last;
        }
        $step = $maxJumps - $i;
    }
}
say $jumps;

