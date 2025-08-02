use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 256
=========================

TASK #1
-------
*Maximum Pairs*

Submitted by: Mohammad Sajid Anwar

You are given an array of distinct words, @words.

Write a script to find the maximum pairs in the given array. The words $words[i]
and $words[j] can be a pair one is reverse of the other.

Example 1

  Input: @words = ("ab", "de", "ed", "bc")
  Output: 1

  There is one pair in the given array: "de" and "ed"

Example 2

  Input: @words = ("aa", "ba", "cd", "ed")
  Output: 0

Example 3

  Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
  Output: 2

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
2. If --case-sensitive is omitted or set to True, "xy" and "XY" (for example)
   are treated as different words, so "xy" and "YX" do NOT form a pair; but if
   --case-sensitive=False is entered on the command-line, "xy" DOES pair with
   "YX".
3. If --palindromes is entered on the command-line, palindromes such as "a",
   "aba", and "CDEDC" pair with themselves; otherwise, they do not, as per
   Example 2.
4. If VERBOSE is set to True, the required output (number of pairs found) is
   followed by a list of the pairs themselves.

=end comment
#===============================================================================

use Test;

my Bool constant CASE-SENSITIVE = True;
my Bool constant PALINDROMES    = False;
my Bool constant VERBOSE        = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 256, Task #1: Maximum Pairs (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Bool:D :$case-sensitive = CASE-SENSITIVE,
    Bool:D :$palindromes    = PALINDROMES,

    #| A non-empty array of distinct words

    *@words where { .elems > 0 && are-distinct( @words, $case-sensitive ) }
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my Pair @pairs = count-pairs( @words, $case-sensitive, $palindromes );

    "Output: %d\n".printf: @pairs.elems;

    if VERBOSE
    {
        "\nPair%s%s\n".printf: @pairs.elems == 1 ?? ':   ' !! 's:  ',
            @pairs.map( { .key ~ '|' ~ .value } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-pairs
(
    List:D[Str:D] $words,
    Bool:D        $case-sensitive,
    Bool:D        $palindromes
--> List:D[Pair:D]
)
#-------------------------------------------------------------------------------
{
    my Pair @pairs;
    my Bool %seen = @$words.map: { $_ => False };

    for @$words.sort -> Str $lhs
    {
        if !%seen{ $lhs }
        {
            for @$words.sort -> Str $rhs
            {
                next if %seen{ $rhs } || (!$palindromes && $lhs eq $rhs);

                if ($case-sensitive && $lhs    eq $rhs.flip) ||
                  (!$case-sensitive && $lhs.lc eq $rhs.lc.flip)
                {
                    @pairs.push: $lhs => $rhs;

                    %seen{ $lhs } = True;
                    %seen{ $rhs } = True;
                }
            }
        }
    }

    return @pairs;
}

#-------------------------------------------------------------------------------
sub are-distinct( List:D[Str:D] $words, Bool:D $case-sensitive --> Bool:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict;

    for @$words
    {
        my Str $word = $case-sensitive ?? $_ !! .lc;

        return False if ++%dict{ $word } > 1;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $expected, $case-sensitive-str,
                $palindromes-str) = $line.split: / \| /;

        for     $test-name, $words-str, $expected, $case-sensitive-str,
                $palindromes-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $case-sensitive = $case-sensitive-str eq 'True';
        my Bool $palindromes    = $palindromes-str    eq 'True';

        my Str  @words = $words-str.split: / \s+ /, :skip-empty;
        my Pair @pairs = count-pairs( @words, $case-sensitive, $palindromes );

        is @pairs.elems, $expected.Int, $test-name;
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
        Example 1    |ab de ed bc      |1|     |
        Example 2    |aa ba cd ed      |0|     |
        Example 3    |uv qp st vu mn pq|2|     |
        Palindromes 1|aba ab ba cd ef g|3|     |True
        Palindromes 2|aba ab ba cd ef g|1|     |False
        Case 1       |ab BA cD dC ef gh|2|False|
        Case 2       |ab BA cD dC ef gh|0|True |
        END
}

################################################################################
