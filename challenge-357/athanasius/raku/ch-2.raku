use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 357
=========================

TASK #2
-------
*Unique Fraction Generator*

Submitted by: Yary

Given a positive integer N, generate all unique fractions you can create using
integers from 1 to N and follow the rules below:

  - Use numbers 1 through N only (no zero)
  - Create fractions like numerator/denominator
  - List them in ascending order (from smallest to largest)
  - If two fractions have the same value (like 1/2 and 2/4),
    only show the one with the smallest numerator

Example 1

  Input: $int = 3
  Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1

Example 2

  Input: $int = 4
  Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1

Example 3

  Input: $int = 1
  Output: 1/1

Example 4

  Input: $int = 6
  Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
          4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
          5/2, 3/1, 4/1, 5/1, 6/1

Example 5

  Input: $int = 5
  Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
          5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1

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
2. A positive (non-zero) integer is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

my UInt constant SCREEN-WIDTH = 80;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 357, Task #2: Unique Fraction Generator (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Pos:D $int                 #= A positive (non-zero) integer
)
#===============================================================================
{
    "Input:  \$int = $int".put;

    my Rat @fractions = get-fractions( $int );

    print-fractions( 'Output: ', @fractions );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub get-fractions( Pos:D $int --> Seq:D[Rat:D] )
#-------------------------------------------------------------------------------
{
    my UInt %fractions{Rat};

    for 1 .. $int -> UInt $num
    {
        for 1 .. $int -> UInt $den
        {
            ++%fractions{ $num / $den };
        }
    }

    return %fractions.keys.sort;
}

#-------------------------------------------------------------------------------
sub print-fractions( Str:D $prefix, List:D[Rat:D] $fractions )
#-------------------------------------------------------------------------------
{
    my UInt $width  = SCREEN-WIDTH - $prefix.chars;
    my Str  $string = $fractions.map( { '%d/%d'.sprintf: .nude } ).join: ', ';
    my Bool $first  = True;
    my Str  $spaces = ' ' x $prefix.chars;

    while $string
    {
        print $first ?? $prefix !! $spaces;

        $first  =  False;
        $string ~~ s/ ^ \s+ //;

        if $string.chars > $width
        {
            my UInt $i = $width;
                  --$i until $string.substr( $i, 1 ) eq ' ';

            say $string.substr:    0, $i;
                $string.substr-rw( 0, $i ) = '';
        }
        else
        {
            $string.put;
            $string = '';
        }
    }
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $int, $expected-str) = $line.split: / \| /;

        for     $test-name, $int, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Rat @fractions = get-fractions( $int.Int );
        my Rat @expected  = $expected-str.split( / \s+ /, :skip-empty )
                                         .map: { .Rat };

        is-deeply @fractions, @expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|3|1/3 1/2 2/3 1/1 3/2 2/1 3/1
        Example 2|4|1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1
        Example 3|1|1/1
        Example 4|6|1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4                        \
                    4/5 5/6 1/1 6/5 5/4 4/3 3/2 5/3 2/1                        \
                    5/2 3/1 4/1 5/1 6/1
        Example 5|5|1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1                    \
                    5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1
        END

    return S:g/ \s* \\ \n \s* / / given $data;
}

################################################################################
