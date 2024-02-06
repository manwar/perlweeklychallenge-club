use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 254
=========================

TASK #1
-------
*Three Power*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to return true if the given integer is a power of three otherwise
return false.

Example 1

  Input: $n = 27
  Output: true

  27 = 3 ^ 3

Example 2

  Input: $n = 0
  Output: true

  0 = 0 ^ 3

Example 3

  Input: $n = 6
  Output: false

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

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
    "\nChallenge 254, Task #1: Three Power (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    UInt:D $n                       #= A positive integer
)
#===============================================================================
{
    "Input:  \$n = $n".put;

    "Output: %s\n".printf: is-three-power( $n ) ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub is-three-power( UInt:D $n --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $cube-root = (($n ** (1 / 3)) + 0.5).floor;

    return $cube-root * $cube-root * $cube-root == $n;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) = $line.split: / \| /;

        for     $test-name, $n, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $result = is-three-power( $n.Int ) ?? 'true' !! 'false';

        is $result, $expected, $test-name;
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
        Example 1  |     27|true
        Example 2  |      0|true
        Example 3  |      6|false
        Large power|1030301|true
        One under  |1030300|false
        One over   |1030302|false
        END
}

################################################################################
