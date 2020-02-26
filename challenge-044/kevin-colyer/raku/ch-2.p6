#!/usr/bin/perl6
use v6;

use Test;


=begin pod

Task 2

Make it $200
You have only $1 left at the start of the week. You have been given an opportunity to make it $200. The rule is simple with every move you can either double what you have or add another $1. Write a script to help you get $200 with the smallest number of moves.

=end pod


# A simple example shows there are about 10 operations I can see. A best solution must be less than this.
# 200 100 50 25 24 12 6 3 1 1
# if I take 10 bits in base two, a 1 is add and a 0 is double.
# Count up to 2**10 and see if == 200, if better keep solution


constant TARGET = 200;
my Int $bal = 1;
my $bestSolution="";
my $bestSolutionMoves=TARGET; # about as infinite as we need
my $bits=TARGET/10; # just a guess
for ^2**10 -> Int $i {
    my Int $j=$i;
    my Int $sum = 1;
    my Str $solution="1";
    my int $moves=0;
    for ^$bits {
        if $j +& 0x1 == 1 {
            $sum+=1;
            last if $sum>TARGET;
            $solution~="+1";
        } else {
            $sum*=2;
            last if $sum>TARGET;
            $solution~="x2";
        }
        $j=$j +> 1;
        $moves++;
        if $sum==TARGET {
            last;
        }
    }
    if $sum==TARGET and $moves < $bestSolutionMoves {
        $bestSolution=$solution ~ "=" ~ TARGET;
        $bestSolutionMoves=$moves;
    }
}

say "$bestSolution in $bestSolutionMoves moves";

