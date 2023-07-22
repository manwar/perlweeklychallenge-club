use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 226
=========================

TASK #1
-------
*Shuffle String*

Submitted by: Mohammad S Anwar

You are given a string and an array of indices of same length as string.

Write a script to return the string after re-arranging the indices in the
correct order.

Example 1

  Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
  Output: 'challenge'

Example 2

  Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
  Output: 'perlraku'

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumption
----------
The indices must be unique and valid, i.e., there must be exactly one index for
each letter in $string.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 226, Task #1: Shuffle String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $string where { .chars > 0 },                    #= A non-empty string

    #| A list of indices, one for each letter in the string

    *@indices where { .all ~~ UInt:D && indices-are-valid( $string, @indices ) }
)
#===============================================================================
{
    "Input:  \$string = '%s', \@indices = (%s)\n".printf:
        $string, @indices.join: ',';

    my Str $new-str = shuffle( $string, @indices );

    "Output: '$new-str'".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub shuffle( Str:D $string, List:D[UInt:D] $indices --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @orig = $string.split: '', :skip-empty; 
    my Str @new;

    for 0 .. $indices.end -> UInt $i
    {
        @new[ $indices[ $i ] ] = @orig[ $i ];
    }

    return @new.join: '';
}

#-------------------------------------------------------------------------------
sub indices-are-valid( Str:D $string, List:D[UInt:D] $indices --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt $length   = $string.chars;

    return False if $indices.elems ≠ $length;

    my UInt @required = 0 .. $length - 1;
    my UInt @actual   = $indices.sort;

    return @actual ~~ @required;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $string, $idx-str, $expected) = $line.split: / \| /;

        for     $test-name, $string, $idx-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @indices = $idx-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Str  $new-str = shuffle( $string, @indices );

        is $new-str, $expected, $test-name;
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
        Example 1  |lacelengh    | 3 2 0 5 4  8 6 7 1         |challenge
        Example 2  |rulepark     | 4 7 3 1 0  5 2 6           |perlraku
        Wikipedia 1|elevenplustwo|12 3 5 4 2 11 6 7 8 9 0 1 10|twelveplusone
        Wikipedia 2|radiumcame   | 7 1 2 8 6  0 5 3 4 9       |madamcurie
        END
}

################################################################################
