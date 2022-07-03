#!/usr/bin/env raku
use v6;

my $h1 = compose(-> ($x, $y) { $x / $y }, -> ($x, $y) { $y, $x });
say $h1(2, 10);

sub compose (&f, &g) { sub {f(g(@_))} }
