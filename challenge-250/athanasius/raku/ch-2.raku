use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 250
=========================

TASK #2
-------
*Alphanumeric String Value*

Submitted by: Mohammad S Anwar

You are given an array of alphanumeric strings.

Write a script to return the maximum value of alphanumeric string in the given
array.

The value of alphanumeric string can be defined as

  a) The numeric representation of the string in base 10 if it is made up of
     digits only.
  b) otherwise the length of the string

Example 1

  Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
  Output: 6

  "perl" consists of letters only so the value is 4.
  "2" is digits only so the value is 2.
  "000" is digits only so the value is 0.
  "python" consits of letters so the value is 6.
  "r4ku" consists of letters and digits so the value is 4.

Example 2

  Input: @alphanumstr = ("001", "1", "000", "0001")
  Output: 1

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. An "alphanumeric string" contains letters and/or digits only. So, "+", "-",
   "_", etc., are not allowed.
2. An empty string has no digits, therefore its value is its length (viz. 0).

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 250, Task #2: Alphanumeric String Value (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of alphanumeric strings

    *@alphanumstr where { .elems > 0 && .all ~~ / ^ <[ A..Z a..z 0..9 ]>* $ / }
)
#===============================================================================
{
    "Input:  \@alphanumstr = (%s)\n".printf:
              @alphanumstr.map( { qq["$_"] } ).join: ', ';

    my UInt  $max-value = find-max-value( @alphanumstr );

    "Output: $max-value".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-value( List:D[Str:D] $alphanumstr --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-value = 0;

    for @$alphanumstr
    {
        my UInt $value = / ^ <[ 0 .. 9 ]>+ $ / ?? .Int !! .chars;

        $max-value     = ($value, $max-value).max;
    }

    return $max-value;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $alphanumstrs, $expected) = $line.split: / \| /;

        for     $test-name, $alphanumstrs, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @alphanumstr = $alphanumstrs.split: / \s+ /;
        my UInt $max-value   = find-max-value( @alphanumstr );

        is $max-value, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1|perl 2 000 python r4ku|6
        Example 2|001  1 000 0001       |1
        END
}

################################################################################
