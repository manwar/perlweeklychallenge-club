#!/usr/bin/env raku

use v6;

# Given a list of number print all those larger than all the others left in the list
sub MAIN(
    *@a where { .all ~~ Int } #= List of integers 
) {
    @a.kv.map( -> $i, $v { $v >= all(@a[$i..*]) ?? $v !! Empty }).join(", ").say;
}
