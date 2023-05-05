#!/usr/bin/perl
use strict;
use warnings;

sub divide {
    my ($M, $N) = @_;

    if ($N == 0) {
        die "Division by zero is not allowed.\n";
    }

    my $sign = (($M < 0) ^ ($N < 0)) ? -1 : 1;
    $M = abs($M);
    $N = abs($N);

    my $result = 0;
    while ($M >= $N) {
        $M -= $N;
        $result++;
    }

    return $sign * $result;
}

my $M = -5;
my $N = -2;
my $output = divide($M, $N);
print "$output\n";

