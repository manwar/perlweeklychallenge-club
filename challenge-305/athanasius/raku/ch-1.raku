use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 305
=========================

TASK #1
-------
*Binary Prefix*

Submitted by: Mohammad Sajid Anwar

You are given a binary array.

Write a script to return an array of booleans where the partial binary number up
to that point is prime.

Example 1

  Input: @binary = (1, 0, 1)
  Output: (false, true, true)

  Sub-arrays (base-10):
  (1): 1 - not prime
  (1, 0): 2 - prime
  (1, 0, 1): 5 - prime

Example 2

  Input: @binary = (1, 1, 0)
  Output: (false, true, false)

  Sub-arrays (base-10):
  (1): 1 - not prime
  (1, 1): 3 - prime
  (1, 1, 0): 6 - not prime

Example 3

  Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
  Output: (false, true, true, false, false, true, false, false, false, false,
  false, false, false, false, false, false, false, false, false, true)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty binary string is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset BinStr of Str where / ^ <[ 0 1 ]>+ $ /;
subset Bin    of Int where 0 | 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 305, Task #1: Binary Prefix (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    BinStr:D $digits,          #= A non-empty string of binary digits
)
#===============================================================================
{
    my Bin @binary = $digits.split( '', :skip-empty ).map: { .Int };

    "Input:  \@binary = (%s)\n".printf: @binary.join: ', ';

    my Bool @prime = binary-prefix( @binary );

    "Output: (%s)\n".printf: @prime.map( { $_ ?? 'true' !! 'false' } )\
                                   .join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub binary-prefix( List:D[Bin:D] $binary --> List:D[Bool:D] )
#-------------------------------------------------------------------------------
{
    my Bool @prime;
    my Str  $bin-str = '';

    for @$binary -> Bin $digit
    {
        $bin-str ~= $digit;

        my UInt $decimal = ":2<$bin-str>".Int;

        @prime.push: $decimal.is-prime;
    }

    return @prime;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $bin-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $bin-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bin  @binary  = $bin-str.split( '', :skip-empty ).map: { .Int };
        my Bool @expectd = $exp-str.split( '', :skip-empty ).map: { $_ eq '1' };
        my Bool @prime   = binary-prefix( @binary );

        is-deeply @prime, @expectd, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|101                 |011
        Example 2|110                 |010
        Example 3|11110100001010010001|01100100000000000001
        END
}

################################################################################
