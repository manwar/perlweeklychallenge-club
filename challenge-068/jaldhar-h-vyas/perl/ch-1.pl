#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no-match-vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <M> <N> [<matrix> ...]
  
    <M>               The number of rows in the matrix
    <N>               The number of columns in the matrix
    [<matrix> ...]    The elements of the matrix
-USAGE-
    exit(0);
}

my $M = shift // usage();
my $N = shift // usage();
if (scalar @ARGV != $M * $N) {
    usage();
}
my @matrix = @ARGV;

my @input = map {[ splice @matrix, 0, $N ]} (0 .. ($M - 1));
my @output = map { [ map { $_ } @{$_} ] } @input;

for my $row (0 .. ($M - 1)) {
    if (grep { $_ == 0 } @{$input[$row]}) {
        for my $col (0 .. ($N - 1)) {
            $output[$row][$col] = 0;
        }
    }
}

for my $col (0 .. ($N - 1)) {
    for my $row (0 .. ($M - 1)) {
        if ($input[$row][$col] == 0) {
            for my $zrow (0 .. ($M - 1)) {
                $output[$zrow][$col] = 0;
            }
            last;
        }
    }
}

for my $row (@output) {
    say q{[}, (join q{ }, @{$row}), q{]};
}
