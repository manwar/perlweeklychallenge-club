use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 172
=========================

TASK #1
-------
*Prime Partition*

Submitted by: Mohammad S Anwar

You are given two positive integers, $m and $n.

Write a script to find out the Prime Partition of the given number. No dupli-
cates allowed.

For example,

  Input: $m = 18, $n = 2
  Output: 5, 13 or 7, 11

  Input: $m = 19, $n = 3
  Output: 3, 5, 11

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
If there are no prime partitions of the required size, the output field is left
blank.

Algorithm
---------
1. Find P, the set of all prime numbers <= m
2. For each n-combination C of the elements of P:
   - find s, the sum of the elements of C
   - if s = m, record C as a prime n-partition of m
3. Output the results

Implementation
--------------
1. Prime numbers between 2 and m are found by filtering integers in this range
   using Raku's built-in is-prime() method.
2. Combinations are found using Raku's built-in combinations() method.

Reference
---------
[1] "Partition (number theory)", Wikipedia,
     https://en.wikipedia.org/wiki/Partition_(number_theory)

=end comment
#==============================================================================

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 172, Task #1: Prime Partition (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Pos:D $m,            #= Positive integer: the number to be partitioned
    Pos:D $n             #= Positive integer: the number of partitions required
)
#==============================================================================
{
    "Input:  \$m = $m, \$n = $n".put;

    my Pos        @primes = (2 .. $m).grep: { .is-prime };
    my Array[Pos] @prime-partitions;

    for @primes.combinations: $n -> List $comb
    {
        my UInt $sum = [+] $comb;

        @prime-partitions.push: Array[Pos].new: |$comb if $sum == $m;
    }

    "Output: %s\n".printf:
        @prime-partitions.map( { '(' ~ .join( ', ' ) ~ ')' } ).join: ', ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
