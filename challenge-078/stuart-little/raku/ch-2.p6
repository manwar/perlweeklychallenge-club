#!/usr/bin/env perl6
use v6;

sub rot(@a,@b) {
    @b.map({ |@a.[$_..*], |@a.[^$_] })
}

my @a=@*ARGS[^(@*ARGS.first('-',:k))];
my @b=@*ARGS[(@*ARGS.first('-',:k))^..*];

for (rot(@a,@b)) {
    .say;
}

# run as <script> <entries of the two arrays, separated by a '-'> with all individual entries space-separated
