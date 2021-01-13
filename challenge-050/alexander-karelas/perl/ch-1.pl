#!/usr/bin/env perl

use v5.28;
use warnings;

use Data::Dumper;

my @intervals = ([2,7], [3,9], [10,12], [15,19], [18,22]);

# solution
@intervals = sort {$a->[0] <=> $b->[0]} @intervals;
for (my $i = 0; $i < $#intervals; $i++) {
    if ($intervals[$i+1][0] <= $intervals[$i][1] and $intervals[$i+1][1] > $intervals[$i][1]) {
        $intervals[$i][1] = $intervals[$i+1][1];
        splice @intervals, $i+1, 1;
    }
}

print Dumper(\@intervals);
