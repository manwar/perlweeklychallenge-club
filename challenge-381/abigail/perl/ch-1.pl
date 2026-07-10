#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

my @matrix = map {[split]} <>;  # Read input
my $r = 1;

for (my $i = 0; $i < @matrix; $i ++) {
    my (%row, %column);
    for (my $j = 0; $j < @matrix; $j ++) {
        $r &&= 1 <= $matrix [$i] [$j] <= @matrix;
        $row {$matrix [$i] [$j]} = $column {$matrix [$j] [$i]} = 1
    }
    $r &&= keys (%row) == @matrix == keys (%column);
}

say $r ? "true" : "false";
