#!/usr/bin/perl6

my @list = < 10 4 1 8 12 3 >;
my @indices = < 0 2 5 >;

[ @indices.map({ @list[$_] }).sort ]
    .map({ state $i = 0; @list[@indices[$i]] = $_; $i++;});

@list.join(q{ }).say;

