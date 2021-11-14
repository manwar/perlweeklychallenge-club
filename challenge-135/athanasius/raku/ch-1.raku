use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 135
=========================

TASK #1
-------
*Middle 3-digits*

Submitted by: Mohammad S Anwar

You are given an integer.

Write a script find out the middle 3-digits of the given integer, if possible
otherwise throw sensible error.

Example 1

  Input: $n = 1234567
  Output: 345

Example 2

  Input: $n = -123
  Output: 123

Example 3

  Input: $n = 1
  Output: too short

Example 4

  Input: $n = 10
  Output: even number of digits

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 135, Task #1: Middle 3-digits (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $n                #= An integer of d digits where d is odd at least 3
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    my UInt $digits = $n.abs.chars;

    if    $digits % 2 == 0
    {
        "Output: \$n has an even number of digits".put;
    }
    elsif $digits < 3
    {
        "Output: \$n has too few digits".put;
    }
    else  # Valid $n
    {
        my UInt @digits  = $n.abs.split( '', :skip-empty ).map: { .Int };
        my UInt $mid-idx = (($digits - 1) / 2).Int;

        "Output: %d%d%d\n".printf: @digits[ $mid-idx - 1 .. $mid-idx + 1 ];
    }
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
