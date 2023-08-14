use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 229
=========================

TASK #1
-------
*Lexicographic Order*

Submitted by: Mohammad S Anwar

You are given an array of strings.

Write a script to delete element which is not lexicographically sorted (forwards
or backwards) and return the count of deletions.

Example 1

  Input: @str = ("abc", "bce", "cae")
  Output: 1

  In the given array "cae" is the only element which is not lexicographically
  sorted.

Example 2

  Input: @str = ("yxz", "cba", "mon")
  Output: 2

  In the given array "yxz" and "mon" are not lexicographically sorted.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Lexicographic order is case-sensitive, and "Z" (upper case) < "a" (lower case).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to True, the solution is followed by a list of the deleted
   elements.

=end comment
#===============================================================================

use Test;

my Bool constant $VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 229, Task #1: Lexicographic Order (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@str where { .elems > 0 }                    #= A non-empty list of strings
)
#===============================================================================
{
    "Input:  \@str = (%s)\n".printf: @str.map( { qq["$_"] } ).join: ', ';

    my Str  @deletions = delete-unsorted( @str );
    my UInt $del-count = @deletions.elems;

    "Output: $del-count".put;

    if $VERBOSE
    {
        "\nDeleted element%s: (%s)\n".printf:
            $del-count == 1 ?? '' !! 's',
            @deletions.map( { qq["$_"] } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub delete-unsorted( List:D[Str:D] $strings --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str @deletions;

    for @$strings
    {
        my Str $as = .split( '', :skip-empty ).sort\                  .join: '';
        my Str $de = .split( '', :skip-empty ).sort( { $^b leg $^a } ).join: '';

        @deletions.push: $_ unless $_ eq $as || $_ eq $de;
    }

    return @deletions;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $string, $expected, $exp-str) = $line.split: / \| /;

        for     $test-name, $string, $expected, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @strings   = $string\.split: / \s+ /, :skip-empty;
        my Str  @exp-strs  = $exp-str.split: / \s+ /, :skip-empty;
        my Str  @deletions = delete-unsorted( @strings );
        my UInt $del-count = @deletions.elems;

        is        $del-count, $expected.Int, "$test-name: count";
        is-deeply @deletions, @exp-strs,     "$test-name: deletions";
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
        Example 1|abc bce cae|1|cae
        Example 2|yxz cba mon|2|yxz mon
        Cases 1  |ABc AbC abC|2|AbC abC
        Cases 2  |Zab jkp XYc|0|
        END
}

################################################################################
