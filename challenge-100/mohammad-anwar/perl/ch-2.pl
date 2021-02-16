#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is(sum([[1], [2,4], [6,4,9], [5,1,7,2]]), 8);
is(sum([[3], [3,1], [5,2,3], [4,3,1,3]]), 7);

done_testing;

sub sum {
    my ($t) = @_;

    my $i = 0;
    my $s = [ $t->[0]->[$i] ];
    shift @$t;
    foreach my $r (@$t) {
        push @$s,
        ($r->[$i] > $r->[$i+1])
        ?($i+=2 and $r->[--$i])
        :($r->[$i]);
    }

    my $sum = 0;
    $sum += $_ for @$s;

    return $sum;
}
