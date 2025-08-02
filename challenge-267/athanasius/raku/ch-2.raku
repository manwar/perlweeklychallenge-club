use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 267
=========================

TASK #2
-------
*Line Counts*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, and a 26-items array @widths containing the width
of each character from a to z.

Write a script to find out the number of lines and the width of the last line
needed to display the given string, assuming you can only fit 100 width units on
a line.

Example 1

  Input: $str = "abcdefghijklmnopqrstuvwxyz"
         @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                    10,10,10,10,10,10)
  Output: (3, 60)

  Line 1: abcdefghij (100 pixels)
  Line 2: klmnopqrst (100 pixels)
  Line 3: uvwxyz (60 pixels)

Example 2

  Input: $str = "bbbcccdddaaa"
         @widths = ( 4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
                    10,10,10,10,10,10)
  Output: (2, 4)

  Line 1: bbbcccdddaa (98 pixels)
  Line 2: a (4 pixels)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Only lower case letters are allowed in $str.
2. Widths are non-zero positive integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The string $str is entered on the command-line, followed by a list of 26
   positive (non-zero) integer widths.

=end comment
#===============================================================================

use Test;

my UInt constant LINE-WIDTH = 100;
my UInt constant NUM-CHARS  =  26;
my UInt constant MID-INDEX  = (NUM-CHARS / 2).ceiling - 1;

subset Width of Int where 0 < * <= LINE-WIDTH;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 267, Task #2: Line Counts (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A string of lowercase letters

    Str:D $str    where { / ^ <[ a..z ]>* $ / },

    #| A 26-item list of character widths

         *@widths where { .elems == NUM-CHARS && .all ~~ Width:D }
)
#===============================================================================
{
    "Input:  \$str    = $str".put;
    "        \@widths = (%s\n".printf: fmt-wds( @widths[ 0   ..   MID-INDEX ] );
    "                   %s)\n".printf: fmt-wds( @widths[ MID-INDEX + 1 .. * ] );

    my UInt  ($lines, $width) = find-line-count( $str, @widths );

    "Output: ($lines, $width)".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-line-count
(
    Str:D           $str    where { / ^ <[ a..z ]>* $ / },
    List:D[Width:D] $widths where { .elems == NUM-CHARS }
--> List:D[UInt:D, UInt:D]
)
#-------------------------------------------------------------------------------
{
    return 0, 0 if $str eq '';

    my UInt $lines = 1;
    my UInt $width = 0;

    for $str.split: '', :skip-empty -> Str $char
    {
        my $units = $widths[ $char.ord - 'a'.ord ];

        if $width + $units > LINE-WIDTH
        {
            ++$lines;
            $width  = $units;
        }
        else
        {
            $width += $units;
        }
    }

    return $lines, $width;
}

#-------------------------------------------------------------------------------
sub fmt-wds( List:D[Width:D] $widths --> Str:D )
#-------------------------------------------------------------------------------
{
    return $widths.map( { '%2d'.sprintf: $_ } ).join: ', ';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $widths-str, $exp-str) = $line.split: / \| /;

        for     $test-name, $str, $widths-str, $exp-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt  @widths         = $widths-str.split( / \s+ / ).map: { .Int };
        my UInt ($lines, $width) = find-line-count( $str, @widths );
        my UInt ($exp-lines,
                 $exp-width)     = $exp-str\  .split( / \s+ / ).map: { .Int };

        is $lines, $exp-lines, "$test-name: total lines";
        is $width, $exp-width, "$test-name: width of last line";
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
    my Str $data = q:to/END/;
        Example 1   |abcdefghijklmnopqrstuvwxyz|                    \
                     10 10 10 10 10 10 10 10 10 10 10 10 10         \
                     10 10 10 10 10 10 10 10 10 10 10 10 10|3 60
        Example 2   |bbbcccdddaaa|                                  \
                      4 10 10 10 10 10 10 10 10 10 10 10 10         \
                     10 10 10 10 10 10 10 10 10 10 10 10 10|2  4
        Empty string||                                              \
                      4 10 10 10 10 10 10 10 10 10 10 10 10         \
                     10 10 10 10 10 10 10 10 10 10 10 10 10|0  0
        Wide chars  |abcdef|                                        \
                     99 98 95 87 49 48 10 10 10 10 10 10 10         \
                     10 10 10 10 10 10 10 10 10 10 10 10 10|5 97
        Narrow chars|abcdefghijklmnopqrstuvwxyz|                    \
                      1  1  1  1  1  1  1  1  1  1  1  1  1         \
                      1  1  1  1  1  1  1  1  1  1  1  1  1|1 26
        END

    $data ~~ s:g/ \\ \n //;                      # Concatenate backslashed lines

    return $data;
}

################################################################################
