#!/usr/bin/perl
use strict;
use warnings;

sub count_fib_sequences {
    my ($n, $i, @fib) = @_;
    if ($n < 0) { return 0; }
    if ($n == 0) { return 1; }
    if ($i == @fib) { return 0; }
    return count_fib_sequences($n - $fib[$i], $i+1, @fib) + count_fib_sequences($n, $i+1, @fib);
}

my @fib = (1, 2, 3, 5, 8, 13, 21, 34, 55, 89);
print count_fib_sequences(16, 0, @fib), "\n";
print count_fib_sequences(9, 0, @fib), "\n";
print count_fib_sequences(15, 0, @fib), "\n";

