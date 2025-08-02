use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 317
=========================

TASK #2
-------
*Friendly Strings*

Submitted by: Mohammad Sajid Anwar

You are given two strings.

Write a script to return true if swapping any two letters in one string match
the other string, return false otherwise.

Example 1

  Input: $str1 = "desc", $str2 = "dsec"
  Output: true

Example 2

  Input: $str1 = "fuck", $str2 = "fcuk"
  Output: true

Example 3

  Input: $str1 = "poo", $str2 = "eop"
  Output: false

Example 4

  Input: $str1 = "stripe", $str2 = "sprite"
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. True is returned if and only if exactly one swap of two letters in the first
   string makes it identical to the second string.
2. The letters swapped must be at different locations within the first string,
   but they may be the same character.
3. Matching is case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 317, Task #2: Friendly Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str1,                        #= First  string
    Str:D $str2                         #= Second string
)
#===============================================================================
{
    qq[Input:  \$str1 = "$str1", \$str2 = "$str2"].put;

    my Bool $friendly = friendly-strings( $str1, $str2 );

    "Output: %s\n".printf: $friendly ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub friendly-strings( Str:D $str1, Str:D $str2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    return False unless $str1.chars == $str2.chars;

    my Str @chars1 = $str1.split: '', :skip-empty;
    my Str @chars2 = $str2.split: '', :skip-empty;

    return False unless @chars1.sort ~~ @chars2.sort;

    for 0 .. @chars1.end -> UInt $i
    {
        for $i + 1 .. @chars1.end -> UInt $j
        {
            my Str @swapped = |@chars1[ 0      .. $i - 1 ], @chars1[ $j ],
                              |@chars1[ $i + 1 .. $j - 1 ], @chars1[ $i ],
                              |@chars1[ $j + 1 .. @chars1.end ];

            return True if @swapped ~~ @chars2;
        }
    }

    return False;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str1, $str2, $expected-str) = $line.split: / \| /;

        for     $test-name, $str1, $str2, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $friendly = friendly-strings( $str1, $str2 );
        my Bool $expected = $expected-str eq 'true';

        is $friendly, $expected, $test-name;
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
        Example 1  |desc  |dsec  |true
        Example 2  |fuck  |fcuk  |true
        Example 3  |poo   |eop   |false
        Example 4  |stripe|sprite|true
        Identical 1|abcdef|abcdef|false
        Identical 2|abccde|abccde|true
        Bookends   |dater |rated |true
        END
}

################################################################################
