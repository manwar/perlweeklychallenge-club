#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <file>
  
    <file>    a file describing a matrix of 1's and 0's where every line is a row in the matrix.
-USAGE-
    exit 0;
}

my $file = shift // usage();

my @matrix;
open my $fn, '<', $file or die "$OS_ERROR\n";
while (my $line = <$fn>) {
    chomp $line;
    push @matrix, [ split //, $line ];
}
close $fn;

my $squares = 0;

for my $m (0 .. scalar @matrix - 1) {
    for my $n (0 .. (scalar @{$matrix[$m]} - 1)) {
        if ($matrix[$m]->[$n] == 1) {
            for (my $side = 1; $n + $side < scalar @{$matrix[$m]}; $side++) {
                if ($matrix[$m]->[$n + $side] == 1
                    && $m + $side < scalar @matrix
                    && $matrix[$m + $side]->[$n] == 1
                    && $matrix[$m + $side]->[$n + $side] == 1) {
                    $squares++;
                }
            } 
        }
    }
}

say $squares;
