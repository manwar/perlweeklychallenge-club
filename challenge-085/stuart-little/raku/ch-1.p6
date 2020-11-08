#!/usr/bin/env perl6
use v6;

sub tripl(@a) {
    @a.combinations(3).grep(1 < *.sum < 2).[0];
}

say (my $res=tripl(@*ARGS.map(*.Real))) ?? ("1: $res") !! 0;

# run as <script> <space-separated numbers>
