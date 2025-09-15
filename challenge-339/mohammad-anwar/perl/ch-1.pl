#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw/max/;

sub max_diff {
    my @n = @_;
    my @pairs = map {
        my $i = $_;
        map { [$i, $_, $n[$i]*$n[$_]] } $i+1 .. $#n
    } 0 .. $#n-1;

    return max
        grep { defined }
        map {
            my ($i,$j,$p1) = @$_;
            map {
                my ($k,$l,$p2) = @$_;
                ($i==$k||$i==$l||$j==$k||$j==$l) ? () : $p1-$p2
            } @pairs
        } @pairs;
}

is(max_diff(5,9,3,4,6),       42);
is(max_diff(1,-2,3,-4),       10);
is(max_diff(-3,-1,-2,-4),     10);
is(max_diff(10,2,0,5,1),      50);
is(max_diff(7,8,9,10,10),     44);
is(max_diff(-1,0,1,2,3,4,5),  23);
is(max_diff(-10,0,1,2,3,4,5), 62);

done_testing;
