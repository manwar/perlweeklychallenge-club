#!/usr/bin/env perl6
use v6;

sub leaf_paths(@t) {
    (@t[1..*].all ~~ Str) && return ((@t[0],),);
    my @left=@t[1..(my $idx = (1..^@t).first({ @t[1..$_].grep(*.Int).elems - @t[1..$_].grep(* ~~ Str).elems == -1 }))];
    my @right=@t[$idx^..*];
    (((@left[0].Int) ?? leaf_paths(@left) !! ()),((@right[0].Int) ?? leaf_paths(@right) !! ())).map(*.map({@t[0], |@$_ })).map(|*)
}

say @*ARGS.map({ $_.Int || $_ }).&leaf_paths.map(*.sum).sum;

=finish

This is *very* similar to 

https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/#TASK2

so I am reusing code.

run as <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . . . 3 5 . . 6 . . represents the tree

     1
    / \
   2   3
  /   / \
 4   5   6

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/

That example would be run as <script> 1 2 4 . . . 3 5 . . 6 . .
The other (first) example would be <script> 1 2 3 . . 4 . . .
