use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 312
=========================

TASK #2
-------
*Balls and Boxes*

Submitted by: Mohammad Sajid Anwar

There are $n balls of mixed colors: red, blue or green. They are all distributed
in 10 boxes labelled 0-9.

You are given a string describing the location of balls.

Write a script to find the number of boxes containing all three colors. Return 0
if none found.

Example 1

  Input: $str = "G0B1R2R0B0"
  Output: 1

  The given string describes there are 5 balls as below:
  Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
  Box 1: Blue(B1) => 1 ball
  Box 2: Red(R2) => 1 ball

Example 2

  Input: $str = "G1R3R6B3G6B1B6R1G3"
  Output: 3

  The given string describes there are 9 balls as below:
  Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
  Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
  Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls

Example 3

  Input: $str = "B3B2G1B3"
  Output: 0

  Box 1: Green(G1) => 1 ball
  Box 2: Blue(B2)  => 1 ball
  Box 3: Blue(B3)  => 2 balls

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
2. A string describing the location of coloured balls in numbered boxes is given
   on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 312, Task #2: Balls and Boxes (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string describing the location of balls in boxes

    Str:D $str where string-is-valid( $str )
)
#===============================================================================
{
    qq[Input:  \$str = "{ $str.uc }"].put;

    my UInt $boxes = count-boxes( $str );

    "Output: $boxes".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-boxes( Str:D $str where string-is-valid( $str ) --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Hash[UInt,Str] @boxes = Hash[UInt,Str].new xx 10;
    my Str            @chars = $str.split: '', :skip-empty;

    while @chars
    {
        my Str  $colour  = @chars.shift.uc;
        my UInt $box-num = @chars.shift.Int;

        ++@boxes[ $box-num ]{ $colour };
    }

    my UInt $count = 0;

    for 0 .. 9 -> UInt $i
    {
        my Hash $box = @boxes[ $i ];

        ++$count if $box< R > && $box< B > && $box< G >;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub string-is-valid( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    return False unless $str.chars %% 2;

    my Str @chars = $str.split: '', :skip-empty;

    while  @chars
    {
        my Str $lhs = @chars.shift;
        my Str $rhs = @chars.shift;

        return False unless $lhs ~~ rx:i/ ^ <[ R B  G ]> $ / &&
                            $rhs ~~     / ^ <[ 0 .. 9 ]> $ /;
    }

    return True;
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

        my UInt $boxes = count-boxes( $str );

        is $boxes, $expected.Int, $test-name;
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
        Example 1|G0B1R2R0B0        |1
        Example 2|G1R3R6B3G6B1B6R1G3|3
        Example 3|B3B2G1B3          |0
        END
}

################################################################################
