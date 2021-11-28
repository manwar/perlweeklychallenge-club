use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 140
=========================

TASK #1
-------
*Add Binary*

Submitted by: Mohammad S Anwar

You are given two decimal-coded binary numbers, $a and $b.

Write a script to simulate the addition of the given binary numbers.

    The script should simulate something like $a + $b. (operator overloading)

Example 1

  Input: $a = 11; $b = 1;
  Output: 100

Example 2

  Input: $a = 101; $b = 1;
  Output: 110

Example 3

  Input: $a = 100; $b = 11;
  Output: 111

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
- "Decimal-coded binary numbers" are just binary numbers
- These binary numbers are restricted to non-negative integers
- Leading zeros are allowed, but will be trimmed.

Solution
--------
The file BinUInt.rakumod contains the implementation of classes BinUInt (for
representing binary numbers) and X::BinUInt::Invalid (for error-reporting).
Binary addition is performed by sub infix:<+>, which is overloaded for BinUInt
objects. This overloaded + operator performs binary addition using the same
logic that a human would use to add two binary numbers together manually.

=end comment
#==============================================================================

use lib < . >;
use BinUInt;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 140, Task #1: Add Binary (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $a,                 #= A non-negative binary integer
    Str:D $b                  #= A non-negative binary integer
)
#==============================================================================
{
    my BinUInt $a-obj = BinUInt.new: value => $a;
    my BinUInt $b-obj = BinUInt.new: value => $b;

    "Input:  \$a = %s; \$b = %s\n".printf: $a-obj.value, $b-obj.value;

    my BinUInt $sum-obj = $a-obj + $b-obj;           # Use operator overloading

    "Output: %s\n".printf: $sum-obj.value;

    CATCH
    {
        when X::BinUInt::Invalid
        {
            ('ERROR: ' ~ .message).put;
            USAGE;
        }
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
