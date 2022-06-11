#!/usr/bin/env perl

# Challenge 050
#
# TASK #1
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
#
# [2,7], [3,9], [10,12], [15,19], [18,22]
#
# The script should merge [2, 7] and [3, 9] together to return [2, 9].
#
# Similarly it should also merge [15, 19] and [18, 22] together to return
# [15, 22].
#
# The final result should be something like below:
#
# [2, 9], [10, 12], [15, 22]

use Modern::Perl;
use List::Util qw( max );

my @int;
while (my($a, $b) = splice(@ARGV, 0, 2)) {
    push @int, [$a, $b];
}

@int = merge_intervals(@int);

my @out = map {"[".$_->[0].", ".$_->[1]."]"} @int;
say join(", ", @out);


sub merge_intervals {
    my(@int) = @_;

    # sort by start time
    @int = sort {$a->[0] <=> $b->[0]} @int;

    # merge consecutive intervals
    for (my $i = 0; $i < @int-1; $i++) {
        my $a = $int[$i];
        my $b = $int[$i+1];
        if ($a->[1] >= $b->[0]) {
            $a->[1] = max($a->[1], $b->[1]);
            splice(@int, $i+1, 1);
            $i--;
        }
    }

    return @int;
}
