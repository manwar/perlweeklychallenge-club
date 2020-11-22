#!/usr/bin/env perl6
use v6;

sub leaf_paths(@t) {
    (@t[1..*].all ~~ Str) && return ((@t[0],),);
    my @left=@t[1..(my $idx = (1..^@t).first({ @t[1..$_].grep(*.Int).elems - @t[1..$_].grep(* ~~ Str).elems == -1 }))];
    my @right=@t[$idx^..*];
    (((@left[0].Int) ?? leaf_paths(@left) !! ()),((@right[0].Int) ?? leaf_paths(@right) !! ())).map(*.map({@t[0], |@$_ })).map(|*)
}

say @*ARGS[1..*].map({ $_.Int || $_ }).&leaf_paths.grep({ $_.sum == @*ARGS[0] });

=finish

run as <script> <target sum> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 5 4 11 7 . . 2 . . . 8 13 . . 9 . 1 . . represents the tree

          5
         / \
        4   8
       /   / \
      11  13  9
     /  \      \
    7    2      1

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/

That example would be run as <script> 22 5 4 11 7 . . 2 . . . 8 13 . . 9 . 1 . ., returning ((5 4 11 2))    
