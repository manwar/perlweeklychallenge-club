#!/usr/bin/env perl6
use v6;

sub fnr(Str $s) {
    $s.split('',:skip-empty).grep({ $s.indices($_) == 1 }).[0] || '#'
}

say (1..@*ARGS[0].chars).map({@*ARGS[0].substr(0,$_)}).map(&fnr);

# run as <script> <space-separated integers>
