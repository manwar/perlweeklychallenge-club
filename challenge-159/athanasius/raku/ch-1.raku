use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 159
=========================

TASK #1
-------
*Farey Sequence*

Submitted by: Mohammad S Anwar

You are given a positive number, $n.

Write a script to compute Farey Sequence of the order $n.

Example 1:

  Input: $n = 5
  Output: 0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1.

Example 2:

  Input: $n = 7
  Output: 0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7,
          3/4, 4/5, 5/6, 6/7, 1/1.

Example 3:

  Input: $n = 4
  Output: 0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
The sequence is restricted to terms in the range 0 to 1 inclusive.

Algorithm
---------
1. The 2 initial terms are always 0/1 and 1/n.
2. Let p/q be the term immediately following a/b, c/d [1: "Next term"]; then
     p = ⌊ (n + b) / d ⌋ × c - a
     q = ⌊ (n + b) / d ⌋ × d - b.
3. The sequence ends when p/q = 1/1.

Reference
---------
[1] "Farey sequence", Wikipedia, https://en.wikipedia.org/wiki/Farey_sequence

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 159, Task #1: Farey Sequence (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where * > 0           #= The order of the required Farey sequence
)
#==============================================================================
{
    my UInt ($a, $b, $c, $d) = 0, 1, 1, $n;

    "Input:  \$n = $n\nOutput: $a/$b, $c/$d".print;

    until $c == $d == 1
    {
        my UInt $t = (($n + $b) / $d).floor;
        my UInt $p = $t * $c - $a;
        my UInt $q = $t * $d - $b;

        ", $p/$q".print;

        ($a, $b, $c, $d) = $c, $d, $p, $q;
    }

    put();
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
