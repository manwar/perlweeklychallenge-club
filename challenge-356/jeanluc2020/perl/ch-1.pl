#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-356/#TASK1
#
# Task 1: Kolakoski Sequence
# ==========================
#
# You are given an integer, $int > 3.
#
# Write a script to generate the Kolakoski Sequence of given length $int and
# return the count of 1 in the generated sequence. Please follow the wikipedia
# page for more informations.
#
## Example 1
## Input: $int = 4
## Output: 2
##
## (1)(22)(11)(2) => 1221
#
## Example 2
## Input: $int = 5
## Output: 3
##
## (1)(22)(11)(2)(1) => 12211
#
## Example 3
## Input: $int = 6
## Output: 3
##
## (1)(22)(11)(2)(1)(22) => 122112
#
## Example 4
## Input: $int = 7
## Output: 4
##
## (1)(22)(11)(2)(1)(22)(1) => 1221121
#
## Example 5
## Input: $int = 8
## Output: 4
##
## (1)(22)(11)(2)(1)(22)(1)(22) => 12211212
#
############################################################
##
## discussion
##
############################################################
#
# Just implement the algorithm from
# https://en.wikipedia.org/wiki/Kolakoski_sequence#Algorithms
# and print the result.
#
use v5.36;

kolakoski_sequence(4);
kolakoski_sequence(5);
kolakoski_sequence(6);
kolakoski_sequence(7);
kolakoski_sequence(8);

sub kolakoski_sequence($int) {
    say "Input: $int";
    my @sequence = ();
    my $next = 1;
    my $how_many = 1;
    my $ones_found = 0;
    foreach my $i (1..$int) {
        if($sequence[$i]) {
            $how_many = $sequence[$i];
            push @sequence, $next;
            push @sequence, $next if $how_many == 2;
        } else {
            $how_many = $i;
            push @sequence, $next;
            push @sequence, $next if $how_many == 2;
        }
        $ones_found++ if $next == 1;
        $next = $next == 1 ? 2 : 1;
    }
    say "Output: $ones_found";
}
