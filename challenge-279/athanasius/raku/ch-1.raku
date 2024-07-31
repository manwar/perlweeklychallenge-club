use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 279
=========================

TASK #1
-------
*Sort Letters*

Submitted by: Mohammad Sajid Anwar

You are given two arrays, @letters and @weights.

Write a script to sort the given array @letters based on the @weights.

Example 1

  Input: @letters = ('R', 'E', 'P', 'L')
         @weights = (3, 2, 1, 4)
  Output: PERL

Example 2

  Input: @letters = ('A', 'U', 'R', 'K')
         @weights = (2, 4, 1, 3)
  Output: RAKU

Example 3

  Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
         @weights = (5, 4, 2, 6, 1, 3)
  Output: PYTHON

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input lists are entered as two strings on the command-line. The first
   string contains only letters; the second string contains positive (non-zero)
   integers separated by whitespace.

=end comment
#===============================================================================

use Test;

subset Letter of Str where m:i/ ^ <[ A .. Z ]> $ /;
subset Pos    of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 279, Task #1: Sort Letters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $letters,        #= A string of letters
    Str:D $weights         #= A string of whitespace-separated positive integers
)
#===============================================================================
{
    my Letter @letters = parse-letters( $letters );
    my Pos    @weights = parse-weights( $weights, @letters.elems );

    "Input:  \@letters = (%s)\n".printf: @letters.map( { "'$_'" } ).join: ', ';
    "        \@weights = (%s)\n".printf: @weights.join: ', ';

    my Str $sorted = sort-letters( @letters, @weights );

    "Output: $sorted".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sort-letters( List:D[Letter:D] $letters, List:D[Pos:D] $weights --> Str:D )
#-------------------------------------------------------------------------------
{
    my Letter @sorted;

    for 0 .. $letters.end -> UInt $i
    {
        @sorted[ $weights[ $i ] - 1 ] = $letters[ $i ];
    }

    return @sorted.join;
}

#-------------------------------------------------------------------------------
sub parse-letters( Str:D $letters --> List:D[Letter:D] )
#-------------------------------------------------------------------------------
{
    my Str    @chars = $letters.split: '', :skip-empty;
    my Letter @letters;

    for @chars -> Str $char
    {
        $char ~~ Letter or error( qq[Invalid letter "$char"] );

        @letters.push: $char;
    }

    return @letters;
}

#-------------------------------------------------------------------------------
sub parse-weights( Str:D $weights, UInt:D $count --> List:D[Pos:D] )
#-------------------------------------------------------------------------------
{
    my Str @nums = $weights.split: / \s+ /, :skip-empty;
    my Pos @weights;

    for @nums -> Str $num
    {
        +$num ~~ Pos         or  error( qq[Invalid weight "$num"] );

        my Pos $weight = +$num;

        $weight <= $count    or  error( "Weight $weight is too large" );

        @weights.push: $weight;
    }

    @weights.elems == $count or  error( 'The number of weights does not ' ~
                                        'match the number of letters' );

    my UInt %dict{Pos};
          ++%dict{ $_ } for @weights;

    for %dict.keys -> Pos $weight
    {
        %dict{ $weight } > 1 and error( "Duplicate weight $weight" );
    }

    return @weights;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $letters, $weights, $expected) =
                $line.split: / \| /;

        for     $test-name, $letters, $weights, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Letter @letters = parse-letters( $letters );
        my Pos    @weights = parse-weights( $weights, @letters.elems );
        my Str    $sorted  = sort-letters\( @letters, @weights );

        is $sorted, $expected, $test-name;
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
        Example 1|REPL  |3 2 1 4    |PERL
        Example 2|AURK  |2 4 1 3    |RAKU
        Example 3|OHYNPT|5 4 2 6 1 3|PYTHON
        END
}

################################################################################
