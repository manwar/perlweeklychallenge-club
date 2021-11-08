#!/usr/bin/perl
use 5.020;
use warnings;

my @N = sort { $b <=> $a } @ARGV;

if ($N[-1] % 2 == 1) {
    my $lasteven = -1;
    while (defined $N[$lasteven] && $N[$lasteven] % 2 == 1) {
        $lasteven--;
    }

    if (defined $N[$lasteven]) {
        my $temp = $N[$lasteven];
        splice @N, $lasteven, 1;
        push @N, $temp;
    } else {
        $N[-1]--;
    }
}

say join q{}, @N;