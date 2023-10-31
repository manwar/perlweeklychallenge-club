use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 240
=========================

TASK #2
-------
*Build Array*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to create an array such that new[i] = old[old[i]] where 0 <= i <
new.length.

Example 1

  Input: @int = (0, 2, 1, 5, 3, 4)
  Output: (0, 1, 2, 4, 5, 3)

Example 2

  Input: @int = (5, 0, 1, 2, 3, 4)
  Output: (4, 5, 0, 1, 2, 3)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. All values in the input list are unsigned integers. 
2. For each i in the range 0 <= i < new.length, if j = old[i] is not in the same
   range (i.e., if j > new.length), then new[i] is undefined, which is displayed
   as "X" in the output list.

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

my Str constant UNDEF = 'X';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 240, Task #2: Build Array (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of non-negative integers

    *@int where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input:  \@int = (%s)\n".printf: @int.join: ', ';

    my UInt @new = build-array( @int );

    "Output:        (%s)\n"\.printf: @new.map( { $_ // UNDEF } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub build-array( List:D[UInt:D] $int --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt @new = Nil xx $int.elems;

    for 0 .. $int.end -> UInt $i
    {
        my UInt $j = $int[ $i ];

        @new[ $i ] = $int[ $j ] if $j <= $int.end;
    }

    return @new;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $int-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @int = $int-str.split( / \s+ / ).map: { .Int };
        my Str  @exp = $exp-str.split: / \s+ /;
        my Str  @new = build-array( @int ).map: { .defined ?? "$_" !! UNDEF };

        is-deeply @new, @exp, $test-name;
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
        Example 1|0 2 1 5 3 4|0 1 2 4 5 3
        Example 2|5 0 1 2 3 4|4 5 0 1 2 3
        Undefined|1 7 2      |7 X 2
        END
}

################################################################################
