#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK1
#
# Task 1: Digital Root
# ====================
#
# You are given a positive integer, $int.
#
# Write a function that calculates the additive persistence of a positive
# integer and also return the digital root.
#
### Digital root is the recursive sum of all digits in a number until a single
### digit is obtained.
#
### Additive persistence is the number of times you need to sum the digits to
### reach a single digit.
#
## Example 1
##
## Input: $int = 38
## Output: Persistence  = 2
##         Digital Root = 2
##
## 38 => 3 + 8 => 11
## 11 => 1 + 1 => 2
#
#
## Example 2
##
## Input: $int = 7
## Output: Persistence  = 0
##         Digital Root = 7
#
#
## Example 3
##
## Input: $int = 999
## Output: Persistence  = 2
##         Digital Root = 9
##
## 999 => 9 + 9 + 9 => 27
## 27  => 2 + 7 => 9
#
#
## Example 4
##
## Input: $int = 1999999999
## Output: Persistence  = 3
##         Digital Root = 1
##
## 1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
## 82 => 8 + 2 => 10
## 10 => 1 + 0 => 1
#
#
## Example 5
##
## Input: $int = 101010
## Output: Persistence  = 1
##         Digital Root = 3
##
## 101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3
#
############################################################
##
## discussion
##
############################################################
#
# We need a simple loop that splits the current value of $int into
# its digits and then calculates the sum. The former can be done
# via split(), the latter can be done via sum() from List::Util, so
# this turns into a oneliner (plus another line for incrementing our
# persistence variable).

use v5.36;
use List::Util qw(sum);

digital_root(38);
digital_root(7);
digital_root(999);
digital_root(1999999999);
digital_root(101010);

sub digital_root($int) {
    say "Input: $int";
    my $persistence = 0;
    while(length($int) > 1) {
        $persistence++;
        $int = sum(split //, $int);
    }
    say "Output: Persistence = $persistence, Digital Root = $int";
}
