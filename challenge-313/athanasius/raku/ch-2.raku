use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 313
=========================

TASK #2
-------
*Reverse Letters*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to reverse only the alphabetic characters in the string.

Example 1

  Input: $str = "p-er?l"
  Output: "l-re?p"

Example 2

  Input: $str = "wee-k!L-y"
  Output: "yLk-e!e-w"

Example 3

  Input: $str = "_c-!h_all-en!g_e"
  Output: "_e-!g_nel-la!h_c"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 313, Task #2: Reverse Letters (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                           #= A string
)
#===============================================================================
{
    qq[Input: \$str = "$str"].put;

    my Str $reversed = reverse-letters( $str );

    qq[Output:       "$reversed"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub reverse-letters( Str:D $str --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @chars = $str.split: '';
    my Str @alpha;

    for 0 .. @chars.end -> UInt $i
    {
        if @chars[ $i ] ~~ m:i/ <[ A .. Z ]> /
        {
            @alpha.push: @chars[ $i ];
            @chars[ $i ] = Nil;
        }
    }

    for 0 .. @chars.end -> UInt $i
    {
        @chars[ $i ] = @alpha.pop unless @chars[ $i ].defined;
    }

    @alpha.elems == 0 or die 'Logic error';

    return @chars.join;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $expected) = $line.split: / \| /;

        $test-name ~~ s/ \s+ $ //;

        my Str $reversed = reverse-letters( $str );

        is $reversed, $expected, $test-name;
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
        Example 1|p-er?l|l-re?p
        Example 2|wee-k!L-y|yLk-e!e-w
        Example 3|_c-!h_all-en!g_e|_e-!g_nel-la!h_c
        END
}

################################################################################
