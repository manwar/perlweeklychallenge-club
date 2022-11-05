use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 189
=========================

TASK #1
-------
*Greater Character*

Submitted by: Mohammad S Anwar

You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array lexico-
graphically greater than the target character.

Example 1

  Input: @array = qw/e m u g/, $target = 'b'
  Output: e

Example 2

  Input: @array = qw/d c e f/, $target = 'a'
  Output: c

Example 3

  Input: @array = qw/j a r/, $target = 'o'
  Output: r

Example 4

  Input: @array = qw/d c a f/, $target = 'a'
  Output: c

Example 5

  Input: @array = qw/t g a l/, $target = 'v'
  Output: v

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

Note
----
From Example 5, it appears that when no characters in the input array satisfy
the given criteria, the target character is the expected output.

=end comment
#==============================================================================

use Test;

my Str  constant $HIGH-CHAR   =  '~'; # Char lexicographically greater than 'z'
my UInt constant $TEST-FIELDS =   4;
my Set  constant $VALID-CHARS = ('a' .. 'z').Set;

subset ValidChar of Str where * ∈ $VALID-CHARS;


#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 189, Task #1: Greater Character (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Str:D       $array,        #= A string of space-separated lowercase letters
    ValidChar:D $target        #= A target character (also 'a' .. 'z')
)
#==============================================================================
{
    my Str @array = $array.split: / \s+ /, :skip-empty;

    for @array -> Str $elem
    {
        $elem ~~ ValidChar
            or error( qq[Array element "$elem" is not a lowercase letter] );
    }

    "Input:  \@array = qw/%s/, \$target = '%s'\n".printf:
        @array.join( ' ' ), $target;

    "Output: '%s'\n".printf: solve( @array, $target );
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub solve( List:D[ValidChar:D] $array, ValidChar:D $target --> ValidChar:D )
#------------------------------------------------------------------------------
{
    my Str $char = $HIGH-CHAR;

    for @$array -> ValidChar $elem
    {
        $char = $elem if $elem gt $target && $elem lt $char;
    }

    $char = $target if $char eq $HIGH-CHAR;

    return $char;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my (Str $test-name, Str $array, ValidChar $target, ValidChar $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS;

        my ValidChar @array = $array.split: / \s+ /, :skip-empty;
        my ValidChar $char  = solve( @array, $target );

        is $char, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,   e m u g, b, e
        Example 2,   d c e f, a, c
        Example 3,   j a r,   o, r
        Example 4,   d c a f, a, c
        Example 5,   t g a l, v, v
        Empty array, ,        q, q
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
