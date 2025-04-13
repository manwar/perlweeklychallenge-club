use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 316
=========================

TASK #2
-------
*Subsequence*

Submitted by: Mohammad Sajid Anwar

You are given two string.

Write a script to find out if one string is a subsequence of another.

  A subsequence of a string is a new string that is formed from the original
  string by deleting some (can be none) of the characters without disturbing the
  relative positions of the remaining characters.

Example 1

  Input: $str1 = "uvw", $str2 = "bcudvew"
  Output: true

Example 2

  Input: $str1 = "aec", $str2 = "abcde"
  Output: false

Example 3

  Input: $str1 = "sip", $str2 = "javascript"
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Matching is case-sensitive.

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
    "\nChallenge 316, Task #2: Subsequence (Raku)\n".put;
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

    my Bool $is-subsequence = subsequence( $str1, $str2 );

    "Output: %s\n".printf: $is-subsequence ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub subsequence( Str:D $str1, Str:D $str2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    return contains( $str1, $str2 ) ||
           contains( $str2, $str1 );
}

#-------------------------------------------------------------------------------
sub contains( Str:D $str1, Str:D $str2 --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Str @whole = $str1.split: '', :skip-empty;
    my Str @part  = $str2.split: '', :skip-empty;

    while  @whole && @part && @whole >= @part
    {
        my Str  $target = @part.shift;
        my Bool $found  = False;

        while @whole
        {
            my Str $next = @whole.shift;

            if $next eq $target
            {
                $found = True;
                last;
            }
        }

        return False unless $found;
    }

    return @part.elems == 0;
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

        my Bool $is-subsequence = subsequence( $str1, $str2 );
        my Bool $expected       = $expected-str eq 'true';

        is $is-subsequence, $expected, $test-name;
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
        Example 1 |uvw    |bcudvew   |true
        Example 2 |aec    |abcde     |false
        Example 3 |sip    |javascript|true
        Identical |abcde  |abcde     |true
        Example 1a|bcudvew|uvw       |true
        Empty 1   |       |uvwxyz    |true
        Empty 2   |uvwxyz |          |true
        Empty 3   |       |          |true
        Doubled   |abbcdef|abccdef   |false
        Case      |Abccde |AbccxzDe  |false
        END
}

################################################################################
