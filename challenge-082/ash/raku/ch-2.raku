#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-082/

unit sub MAIN(Str $a, Str $b, Str $c);

my @parts;
for ^$a.chars -> $pos {
    say 1 and return if $c eq $a.substr(0, $pos) ~ $b ~ $a.substr($pos);
}

# Not sure if the below tests agree with the idea of the task.

say 2 and return if $c eq $a ~ $b;

for ^$b.chars -> $pos {    
    say 3 and return if $c eq $b.substr(0, $pos) ~ $a ~ $b.substr($pos);
}

say 4 and return if $c eq $b ~ $a;

say 0;
