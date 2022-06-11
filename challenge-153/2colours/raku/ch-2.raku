#!/usr/bin/env raku

my $n = prompt('Input: $n = ').Int;
my @digits = $n ~~ m:g/\d/;
my @factorials = @digits.map({[*] (1..$_)});
my $is-equal = @factorials.sum == $n;
say "Output: {$is-equal.Int}";
say "Since {@digits >>~>> '!' andthen .join(' + ')} => {@factorials.join(' + ')} {$is-equal ?? '=' !! '<>'} $n";

