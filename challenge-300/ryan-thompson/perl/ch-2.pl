#!/usr/bin/env perl
#
# Nested array: given an array of @ints, return the length
# of the longest chain where we map
#    $i .. $ints[$i] .. $ints[$ints[$i]] ...
# Until we reach a cycle (i.e., we've $seen{ $ints[...$ints[i]] })

use 5.038;
use List::Util qw< max >;

sub longest_set_len(@ints) {
    max map {
        my %seen;
        $_ = $ints[$_] while not $seen{$_}++;
        scalar keys %seen;
    } 0..$#ints;
}

say longest_set_len(5,4,0,3,1,6,2); # 4
