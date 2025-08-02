use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 256
=========================

TASK #2
-------
*Merge Strings*

Submitted by: Mohammad Sajid Anwar

You are given two strings, $str1 and $str2.

Write a script to merge the given strings by adding in alternative order start-
ing with the first string. If a string is longer than the other then append the
remaining at the end.

Example 1

  Input: $str1 = "abcd", $str2 = "1234"
  Output: "a1b2c3d4"

Example 2

  Input: $str1 = "abc", $str2 = "12345"
  Output: "a1b2c345"

Example 3

  Input: $str1 = "abcde", $str2 = "123"
  Output: "a1b2c3de"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 256, Task #2: Merge Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str1,                       #= A string
    Str:D $str2                        #= Another string
)
#===============================================================================
{
    qq[Input:  \$str1 = "$str1", \$str2 = "$str2"].put;

    my Str $merged = merge-strings( $str1, $str2 );

    qq[Output: "$merged"].put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub merge-strings( Str:D $str1, Str:D $str2 --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str @chars1 = $str1.split: '', :skip-empty;
    my Str @chars2 = $str2.split: '', :skip-empty;
    my Str @merged = roundrobin @chars1, @chars2, :slip;

    return @merged.join;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str1, $str2, $expected) = $line.split: / \| /;

        for     $test-name, $str1, $str2, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $merged = merge-strings( $str1, $str2 );

        is $merged, $expected, $test-name;
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
        Example 1|abcd |1234 |a1b2c3d4
        Example 2|abc  |12345|a1b2c345
        Example 3|abcde|123  |a1b2c3de
        END
}

################################################################################
