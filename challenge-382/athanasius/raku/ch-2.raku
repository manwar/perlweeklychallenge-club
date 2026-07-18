use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 382
=========================

TASK #2
-------
*Replace Question Mark*

Submitted by: Simon Green

You are given a string that contains only 0, 1 and ? characters.

Write a script to generate all possible combinations when replacing the question
marks with a zero or one.

Example 1

  Input: $str = "01??0"
  Output: ("01000", "01010", "01100", "01110")

Example 2

  Input: $str = "101"
  Output: ("101")

Example 3

  Input: $str = "???"
  Output: ("000", "001", "010", "011", "100", "101", "110", "111")

Example 4

  Input: $str = "1?10"
  Output: ("1010", "1110")

Example 5

  Input: $str = "1?1?0"
  Output: ("10100", "10110", "11100", "11110")

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
2. A string containing only the characters "0", "1", and "?" is entered on the
   command-line.

=end comment
#===============================================================================

use Test;

subset BinStr of Str where / ^ <[ 0 1   ]>* $ /;
subset BnQStr of Str where / ^ <[ 0 1 ? ]>* $ /;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 382, Task #2: Replace Question Mark (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    BnQStr:D $str   #= A string containing only the characters "0", "1", and "?"
)
#===============================================================================
{
    qq[Input:  \$str = "$str"].put;

    my BinStr @combs = generate-combinations( $str );

    "Output: (%s)\n".printf: @combs.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub generate-combinations( BnQStr:D $str --> List:D[BinStr:D] )
#-------------------------------------------------------------------------------
{
    my BinStr @combs = '';
    my BnQStr @chars = $str.split: '', :skip-empty;

    for @chars -> BnQStr $char
    {
        if $char eq '?'
        {
            my BinStr @temp;

            @temp.push: $_ ~ '0', $_ ~ '1' for @combs;

            @combs = @temp;
        }
        else
        {
            $_ ~= $char for @combs;
        }
    }

    return @combs;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name,  @input) = $line.split: '|';

        for     $test-name, |@input
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my BnQStr $str   = @input.shift;
        my BinStr @exp   = @input;
        my BinStr @combs = generate-combinations( $str );

        is-deeply @combs, @exp, $test-name;
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
        Example 1|01??0|01000|01010|01100|01110
        Example 2|101  |101
        Example 3|???  |000|001|010|011|100|101|110|111
        Example 4|1?10 |1010|1110
        Example 5|1?1?0|10100|10110|11100|11110
        Empty str|     |
        END
}

################################################################################
