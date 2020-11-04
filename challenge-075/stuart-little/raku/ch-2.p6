#!/usr/bin/env perl6
use v6;

sub rect(@a) {
    @a
    .keys
    .combinations(2)
    .map({ @a[$_.[0]..$_.[1]].min*($_.[1]-$_.[0]+1) })
    .max
}

sub hist(@a) {
    (1..@a.max)
    .map( -> $val { @a.keys.map({
($val <= @a.[$_]) ?? ('#') !! (' ') })
		  })
    .reverse
    .join("\n")
}

say hist(@*ARGS.map(*.Int)),
"\n" ~ ('- ' x @*ARGS) ~ "\n",
max(rect(@*ARGS.map(*.Int)), @*ARGS.map(*.Int).max);

# run as <script> <space-separated numbers>
