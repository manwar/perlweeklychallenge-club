use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 193
=========================

TASK #1
-------
*Binary String*

Submitted by: Mohammad S Anwar

You are given an integer, $n > 0.

Write a script to find all possible binary numbers of size $n.

Example 1

  Input: $n = 2
  Output: 00, 11, 01, 10

Example 2

  Input: $n = 3
  Output: 000, 001, 010, 100, 111, 110, 101, 011

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

=end comment
#==============================================================================

use Test;

subset Pos of Int where * > 0;

my UInt constant $TEST-FIELDS = 3;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 193, Task #1: Binary String (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Pos:D $n                  #= An integer greater than zero
)
#==============================================================================
{
    "Input:  \$n = $n".put;
    "Output: %s\n".printf: find-binary-numbers( $n ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub find-binary-numbers( Pos:D $n --> List:D[Str:D] )
#------------------------------------------------------------------------------
{
    my Str @binaries;

    for 0 .. 2 ** $n - 1 -> UInt $i
    {
        @binaries.push: '%0*b'.sprintf: $n, $i;
    }

    return @binaries;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) =
                $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        my Str  @expected = $expected.split( / \s+ /, :skip-empty ).sort;

        is-deeply( find-binary-numbers( $n.Int ), @expected, $test-name );
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1, 2, 00 11 01 10
        Example 2, 3, 000 001 010 100 111 110 101 011
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
