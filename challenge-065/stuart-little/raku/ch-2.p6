#!/usr/bin/env perl6
use v6;

sub is_pal($s) {
    $s.chars >=1 && ($s eq $s.flip)
}

sub start_pal_indices($s) {
    (1..$s.chars).grep({ $s.substr(0..^$_).&is_pal })
}

sub part_pal($s) {
    $s eq '' && return ((),);
    $s.chars==1 && return (($s,),);
    return $s.&start_pal_indices.map({ $s.substr($_).&part_pal.map( -> @p {($s.substr(0..^$_),|@p)}) }).map(|*)
}

for @*ARGS[0].&part_pal.classify(*.elems).min(*.key) {.say}

=finish
run as <script> <string>

Due to the ambiguity in the original problem I elected to implement

https://leetcode.com/problems/palindrome-partitioning-ii/description/

instead.
