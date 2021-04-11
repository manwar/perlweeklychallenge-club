#!/usr/bin/env perl6
use v6;

# run <script>

my %res = (
    100 => [4,1210],
    136 => [4,2020],
    1425 => [5,21200],
    );

for (%res.keys.sort({$_.Int})) {
    say "Base 10: $_";
    say sprintf("Base %s: %s\n", %res{$_}.[0], %res{$_}.[1]);
}

