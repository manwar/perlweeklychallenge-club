#!/usr/bin/env perl6
use v6;

my $s='';

for (1..((@*ARGS) ?? @*ARGS[0].Int !! 10)) {
    $s ~= ('0' ~ $s.trans('01' => '10').flip )
}

say $s

# run as <script> <number of iterations (a positive integer; defaults to 10)>
