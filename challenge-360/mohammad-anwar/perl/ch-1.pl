#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my %examples = (
    4   => "3,1"   ,
    12  => "8,3,1" ,
    20  => "13,5,2",
    96  => "89,5,2",
    100 => "89,8,3",
);

is zeckendorf($_), $examples{$_} for keys %examples;

done_testing;

sub zeckendorf {
    my $n = shift;
    my @f = (1, 2);

    push(@f, $f[-1] + $f[-2]) while $f[-1] <= $n;
    pop @f;
    my @r;
    for (my $i = $#f; $i >= 0; $i--) {
        if ($f[$i] <= $n) {
            push @r, $f[$i];
            $n -= $f[$i];
        }
    }

    return join ",", @r;
}
