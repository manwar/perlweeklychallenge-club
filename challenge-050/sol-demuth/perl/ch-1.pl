#!/usr/bin/perl

use strict;
use warnings;

my @sets = (
    [2,7], [3,9], [10,12], [15,19], [18,22],
);

print "Intervals:\n". dumpSets(@sets);

@sets = sort {
    # pre-sort by beginning then end of intervals
    # allows maintaining single array for merge tracking
    (
        $a->[0] <=> $b->[0]
    ) || (
        $a->[1] <=> $b->[1]
    )
} @sets;

my $cur = undef;
my $i   = 0; # cleaner than for loop, IMHO

foreach my $nxt (@sets) {
    if (
           !$cur # start
        || $cur->[1] < $nxt->[0] # no overlap, increment
    ) {
        $cur = $nxt;
    } else {
        # part overlap, next interval ends after current
        if ($cur->[1] < $nxt->[1]) {
            # current takes end of next
            $cur->[1] = $nxt->[1];
        }
        # consume next
        splice @sets, $i, 1;
    }

    $i++;
}

print "Merged:\n" . dumpSets(@sets);

sub dumpSets { # convenience for printing sets of intervals
    return join(', ',
        map { '[' . $_->[0] . ', ' . $_->[1] . ']' } @_
    ) . "\n";
}
