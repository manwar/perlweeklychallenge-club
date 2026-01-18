use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 356
=========================

TASK #1
-------
*Kolakoski Sequence*

Submitted by: Mohammad Sajid Anwar

You are given an integer, $int > 3.

Write a script to generate the Kolakoski Sequence of given length $int and
return the count of 1 in the generated sequence. Please follow the
[ https://en.wikipedia.org/wiki/Kolakoski_sequence |wikipedia page] for more
informations.

Example 1

  Input: $int = 4
  Output: 2

  (1)(22)(11)(2) => 1221

Example 2

  Input: $int = 5
  Output: 3

  (1)(22)(11)(2)(1) => 12211

Example 3

  Input: $int = 6
  Output: 3

  (1)(22)(11)(2)(1)(22) => 122112

Example 4

  Input: $int = 7
  Output: 4

  (1)(22)(11)(2)(1)(22)(1) => 1221121

Example 5

  Input: $int = 8
  Output: 4

  (1)(22)(11)(2)(1)(22)(1)(22) => 12211212

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
2. An integer greater than 3 is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset KSym of Int where * ~~ 1 | 2;

my constant @INIT-SEQ = Array[KSym].new: 1, 2, 2;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 356, Task #1: Kolakoski Sequence (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Int:D $int where * > @INIT-SEQ.elems            #= An integer greater than 3
)
#===============================================================================
{
    "Input:  \$int = $int".put;

    my UInt $ones = count-ones( $int );

    "Output: $ones".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-ones( Int:D $int where * > @INIT-SEQ.elems --> UInt:D )
#-------------------------------------------------------------------------------
{
    my KSym @seq = @INIT-SEQ;
    my UInt $i   = @seq.end;
    my KSym $sym = @seq[*-1] == 1 ?? 2 !! 1;

    while $int > @seq.elems
    {
        @seq.push: |( $sym xx @seq[$i++] );

        $sym = ($sym == 1) ?? 2 !! 1;
    }

    @seq.pop while @seq.elems > $int;

    return @seq.grep( { $_ == 1 } ).elems;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $expected) = $line.split: / \| /;

        for     $test-name, $int, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt $ones = count-ones( $int.Int );

        is $ones, $expected.Int, $test-name;
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
        Example 1|  4| 2
        Example 2|  5| 3
        Example 3|  6| 3
        Example 4|  7| 4
        Example 5|  8| 4
        OEIS     |108|53
        END
}

################################################################################
