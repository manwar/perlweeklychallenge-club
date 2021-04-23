#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [<N> ...]

    [<N> ...]    an array of integers
-USAGE-
    exit 0;
}

if (!scalar @ARGV) {
    usage();
}

if (scalar @ARGV == 1) {
    say 0;
} else {
    my @N = sort @ARGV;

    my $previous = $N[0];
    my $largest = -Inf;
    for my $i (1 .. scalar @N - 1) {
        my $gap =  $N[$i] - $previous;
        if ($gap > $largest) {
            $largest = $gap;
        }
        $previous = $N[$i];
    }
    say $largest;
}