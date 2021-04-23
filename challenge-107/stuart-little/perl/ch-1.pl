#!/usr/bin/perl
use warnings;
use v5.12;

# run <script>

my %res = (
    100 => [4,1210],
    136 => [4,2020],
    1425 => [5,21200],
    );

for (sort {int $_} keys %res) {
    say "Base 10: $_";
    say sprintf("Base %s: %s\n", $res{$_}->[0], $res{$_}->[1]);
}
