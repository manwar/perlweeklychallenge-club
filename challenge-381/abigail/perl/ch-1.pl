#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

my @matrix = map {[split]} <>;  # Read input
my $r = 1;
my %diffs;

foreach my $r_i (keys @matrix) {
    my $row = $matrix [$r_i];
    $r &&= @$row == @matrix;             # Size check
    foreach my $c_i (keys @$row) {
        my $n = $$row [$c_i];
        $r &&= 1 <= $n <= @matrix;       # Bounds check
        $diffs {"rows_$r_i"} {$n} = 1;   # Numbers by row/column
        $diffs {"cols_$c_i"} {$n} = 1;
    }
}

$r &&= @matrix == keys %$_ for values %diffs;  # All different in row/column

say $r ? "true" : "false";
