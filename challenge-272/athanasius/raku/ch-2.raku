use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 272
=========================

TASK #2
-------
*String Score*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to return the score of the given string.

    The score of a string is defined as the sum of the absolute difference
    between the ASCII values of adjacent characters.

Example 1

  Input: $str = "hello"
  Output: 13

  ASCII values of characters:
  h = 104
  e = 101
  l = 108
  l = 108
  o = 111

  Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
        => 3 + 7 + 0 + 3
        => 13

Example 2

  Input: "perl"
  Output: 30

  ASCII values of characters:
  p = 112
  e = 101
  r = 114
  l = 108

  Score => |112 - 101| + |101 - 114| + |114 - 108|
        => 11 + 13 + 6
        => 30

Example 3

  Input: "raku"
  Output: 37

  ASCII values of characters:
  r = 114
  a = 97
  k = 107
  u = 117

  Score => |114 - 97| + |97 - 107| + |107 - 117|
        => 17 + 10 + 10
        => 37

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Command-line input is assumed to be ASCII-encoded.
2. The input string may contain only printable ASCII characters, in the range
   ' ' (space, value 0x20 = 32) to '~' (tilde, value 0x7E = 176).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input string is entered on the command-line.

=end comment
#===============================================================================

use Test;

my Str constant ASCII-MAX = '~';
my Str constant ASCII-MIN = ' ';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 272, Task #2: String Score (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str            #= A string of printable ASCII characters
)
#===============================================================================
{
    for $str.split: '', :skip-empty
    {
        ASCII-MIN le $_ le ASCII-MAX
            or error( qq["$_" (chr { .ord.base( 16 ) }) is not a printable ] ~
                       'ASCII character' );
    }

    qq[Input:  \$str = "$str"].put;

    my UInt $score = find-string-score( $str );

    "Output: $score".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-string-score( Str:D $str --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt @ascii = $str.split( '', :skip-empty ).map: { .ord };
    my UInt $score = 0;

    for 0 .. @ascii.end - 1 -> UInt $i
    {
        $score += ( @ascii[ $i ] - @ascii[ $i + 1 ] ).abs;
    }

    return $score;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $score = find-string-score( $str );

        is $score, $expected.Int, $test-name;
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
        Example 1|hello|13
        Example 2|perl |30
        Example 3|raku |37
        END
}

################################################################################
