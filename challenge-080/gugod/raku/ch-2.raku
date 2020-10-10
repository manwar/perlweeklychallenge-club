#!/usr/bin/env raku

# Usage:
#   raku ./challenge-080/gugod/raku/ch-2.raku 1 4 3 2
#   7

my @N = @*ARGS.map({ .Int });

my $extra = (1..@N.end).grep(-> $i { @N[$i] != @N[$i-1] }).elems;

say @N.elems + $extra;
