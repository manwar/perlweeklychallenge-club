#!/usr/bin/perl
use v5.38;

sub minOf3($a, $b, $c) {
    return $a < $b ? ($a < $c ? $a : $c) : ($b < $c ? $b : $c);
}

my @matrix;

for my $row (@ARGV) {
    push @matrix, [ split //, $row ];
}

my $rows = scalar @matrix;
my $cols = scalar @{$matrix[0]};
my $maxSide = 0;


my @sl = map { [(0) x $cols] } (0 .. $rows - 1);

for my $i (0 .. $rows - 1) {
    for my $j (0 .. $cols - 1) {

        if ($matrix[$i][$j] == 1) {
            $sl[$i][$j] = ($i == 0 || $j == 0)
              ? 1
              : minOf3($sl[$i - 1][$j],$sl[$i][$j -1 ],$sl[$i - 1][$j - 1]) + 1;

            if ($sl[$i][$j] > $maxSide) {
                $maxSide = $sl[$i][$j];
            }
        }
    }
}

say $maxSide * $maxSide;
