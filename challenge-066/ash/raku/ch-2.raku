#!/usr/bin/env raku

my $n = 9;
# my $n = 45;

say $n ∈ [X**] ((1..$n.sqrt) xx 2);
