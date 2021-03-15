#!/usr/bin/env perl6
use v6;

# run <script> <nr elements to display; defaults to 50>

sub fusc($n) {
    my @a=(0,1);
    for (2..$n-1) {
	@a.push(($_ %% 2) ?? (@a[$_ div 2]) !! (@a[($_-1) div 2]+@a[($_+1) div 2]));
    }
    return @a;
}

for fusc((@*ARGS) ?? (@*ARGS[0].Int) !! (50)) {.say};
