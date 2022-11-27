use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 192
=========================

TASK #1
-------
*Binary Flip*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to find the binary flip.

Example 1

  Input: $n = 5
  Output: 2

  First find the binary equivalent of the given integer, 101.
  Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
  So Binary 010 => Decimal 2.

Example 2

  Input: $n = 4
  Output: 3

  Decimal 4 = Binary 100
  Flip 0 -> 1 and 1 -> 0, we get 011.
  Binary 011 = Decimal 3

Example 3

  Input: $n = 6
  Output: 1

  Decimal 6 = Binary 110
  Flip 0 -> 1 and 1 -> 0, we get 001.
  Binary 001 = Decimal 1

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
A "positive integer" is a non-negative integer (i.e., one greater than or equal
to zero).

Solution
--------
1. Raku's base() method with argument 2 translates the integer to its corres-
   ponding binary string.
2. The transliteration operator TR/// flips the digits in the binary string.
3. Conversion of the flipped binary string to a decimal integer is accomplished
   by the application of radix notation to the string: :2( $flipped ).

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 192, Task #1: Binary Flip (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    UInt:D $n                      #= A positive integer
)
#==============================================================================
{
    "Input:  \$n = $n".put;
    "Output: %d\n".printf: binary-flip( $n );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub binary-flip( UInt:D $n --> UInt:D )
#------------------------------------------------------------------------------
{
    my Str $binary  = $n.base( 2 );
    my Str $flipped = TR/01/10/ with $binary;

    return :2( $flipped );
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS;

        is binary-flip( $n.Int ), $expected.Int, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,     5,   2
        Example 2,     4,   3
        Example 3,     6,   1
        Power of 2,  128, 127
        Alternating, 170,  85
        Two and one, 438,  73
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
