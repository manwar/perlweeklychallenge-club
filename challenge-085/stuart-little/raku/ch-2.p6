#!/usr/bin/env perl6
use v6;

sub pw($n) {
    ((1..^$n) X (2..^$n)).grep({ ($_[0] ** $_[1]) == $n }).map({ qq{$_[0]^$_[1]=$n} }).[0]
}

say (my $res=pw(@*ARGS[0].Int)) ?? ("1: $res") !! (0);

# run as <script> <number>
