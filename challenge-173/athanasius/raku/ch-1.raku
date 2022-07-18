use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 173
=========================

TASK #1
-------
*Esthetic Number*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find out if the given number is Esthetic Number.


    An esthetic number is a positive integer where every adjacent digit differs
    from its neighbour by 1.


For example,

  5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
  120 is not an esthetic number as |1 - 2| != |2 - 0| != 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note on Leading Zeros
---------------------
$n might be input as "0345434", which would fail the esthetic test because
|0 - 3| != 1. But since $n is specified as a positive integer, I have chosen to
interpret "0345434" as 345434, which passes the test.

Algorithm
---------
This is straightforward: test each digit from first to second-last against its
successor: if the absolute value of the difference between them is not 1, $n is
not esthetic; if all digits pass this test, $n is esthetic.

Note that "differs from its neighbour by 1" is a commutative operation, so it
is only necessary to test the digits in one direction.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 173, Task #1: Esthetic Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where * > 0                #= A positive integer
)
#==============================================================================
{
    my UInt $m = $n + 0;                 #  Remove any initial zeros

    my Bool $esthetic = is-esthetic( $m );

    "%d is%s an esthetic number\n".printf: $m, $esthetic ?? '' !! ' not';
}

#------------------------------------------------------------------------------
sub is-esthetic( UInt:D $n where * > 0 --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt @digits = $n.split( '', :skip-empty ).map: { .Int };

    for 0 .. @digits.end - 1 -> UInt $i
    {
        return False unless (@digits[ $i ] - @digits[ $i + 1 ]).abs == 1;
    }

    return True;
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
