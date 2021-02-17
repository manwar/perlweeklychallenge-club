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
    my $s = (@{shift @$t})[0];
    $s += ($_->[$i] > $_->[$i+1])?($i+=2 and $_->[--$i]):($_->[$i]) for @$t;
    return $s;
}
