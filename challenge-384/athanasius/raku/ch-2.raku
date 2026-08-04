use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 384
=========================

TASK #2
-------
*Special Binary Substrings*

Submitted by: Mohammad Sajid Anwar

You are given a binary string.

Write a script to return all non-empty substrings (distinct) that have the same
number of 0’s and 1’s, and all the 0’s and all the 1’s in these substrings are
grouped consecutively.

Example 1

  Input: $binary = "0101"
  Output: ("01", "10")

Example 2

  Input: $binary = "000111"
  Output: ("000111", "0011", "01")

Example 3

  Input: $binary = "000011"
  Output:  ("0011", "01")

Example 4

  Input: $binary = "10011100"
  Output: ("10", "0011", "01", "1100")

Example 5

  Input: $binary = "00000"
  Output: ()

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A binary string is entered on the command-line.

Assumption
----------
Since the Task description does not specify the order in which substrings are to
be output, I assume that the Example outputs may be re-ordered to match the out-
put of the algorithm used.

Algorithm
---------
Search the input string for candidate substrings, from shortest to longest. In
each case, search for the substring beginning with '0' before searching for its
counterpart beginning with '1'. Hence, the search proceeds as follows:

    01, 10, 0011, 1100, 000111, 111000, ...

=end comment
#===============================================================================

use Test;

subset BinStr of Str where / ^ <[ 0 1 ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 384, Task #2: Special Binary Substrings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    BinStr:D $binary                     #= A binary string
)
#===============================================================================
{
    qq[Input:  \$binary = "$binary"].put;

    my BinStr @substrs = find-special-substrings( $binary );

    "Output: (%s)\n".printf: @substrs.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-special-substrings( BinStr:D $binary --> List:D[BinStr:D] )
#-------------------------------------------------------------------------------
{
    my BinStr @substrs;

    for 1 .. ($binary.chars / 2).floor -> UInt $len
    {
        my Str $sub = '0' x $len ~ '1' x $len;

        for $sub, $sub.flip -> Str $s
        {
            @substrs.push: $s if $binary ~~ / $s /;
        }
    }

    return @substrs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $binary,  @exp-strs) = $line.split: '|';

        for     $test-name, $binary, |@exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my BinStr @substrs  = find-special-substrings( $binary );
        my BinStr @expected = @exp-strs;

        is-deeply @substrs, @expected, $test-name;
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
        Example 1|0101    |01|10
        Example 2|000111  |01|0011|000111
        Example 3|000011  |01|0011
        Example 4|10011100|01|10|0011|1100
        Example 5|00000
        END
}

################################################################################
