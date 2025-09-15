#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw/max/;

sub max_diff {
    my @nums = @_;

    # For 4 elements, there are only 3 possible pairings
    if (@nums == 4) {
        my ($a, $b, $c, $d) = @nums;
        return max(
            $a*$b - $c*$d,
            $a*$c - $b*$d,
            $a*$d - $b*$c,
        );
    }

    # For larger arrays, we need to consider extreme values
    my @s = sort {$a <=> $b} @nums;
    my ($l1, $l2, $l3, $s1, $s2, $s3) =
        ($s[-1], $s[-2], $s[-3], $s[0], $s[1], $s[2]);

    my $opt1 = $l1*$l2 - $s1*$s2;
    my $opt2 = $l1*$s1 - $l2*$s2;
    my $opt3 = $l1*$s2 - $l2*$s1;
    my $opt4 = $l1*$l2 - $l1*$s3;
    my $opt5 = $s1*$s2 - $l1*$s3;
    my $opt6 = $s1*$l3 - $l1*$s1;
    my $opt7 = $s2*$s3 - $l1*$s1;

    return max($opt1, $opt2, $opt3, $opt4, $opt5, $opt6, $opt7);
}

is(max_diff(5,9,3,4,6),       42);
is(max_diff(1,-2,3,-4),       10);
is(max_diff(-3,-1,-2,-4),     10);
is(max_diff(10,2,0,5,1),      50);
is(max_diff(7,8,9,10,10),     44);
is(max_diff(-1,0,1,2,3,4,5),  23);
is(max_diff(-10,0,1,2,3,4,5), 62);

done_testing;
