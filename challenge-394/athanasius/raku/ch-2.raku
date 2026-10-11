use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 394
=========================

TASK #2
-------
*Alternating Vowels Consonants*

Submitted by: Mohammad Sajid Anwar

You are given three strings containing English alphabetic characters.

Find all the longest contiguous substrings common to all three strings that
strictly alternate between vowels and consonants.

Example 1

  Input: @str = ("relocate", "delocate", "allocate")
  Output: ("locate")

Example 2

  Input: @str = ("apple", "banana", "cherry")
  Output: ()

Example 3

  Input: @str = ("navigate", "cavity", "gravity")
  Output: ("avi")

Example 4

  Input: @str = ("pedalgia", "pedalboard", "pedantic")
  Output: ("peda")

Example 5

  Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
  Output: ("ho", "ol")

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
2. Three strings, each containing letters from the English alphabet only, are
   entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Alpha of Str where { / ^ <[ A..Z a..z ]>* $ / };

my constant @VOWELS = < A a E e I i O o U u >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 394, Task #2: Alternating Vowels Consonants (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| 3 strings containing letters from the English alphabet only

    *@str where { .elems == 3 && .all ~~ Alpha:D }
)
#===============================================================================
{
    "Input:  \@str = (%s)\n".printf:    @str.map( { qq["$_"] } ).join: ', ';

    my Alpha @substr = find-longest-substrs( @str );

    "Output: (%s)\n"\       .printf: @substr.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-longest-substrs
(
    List:D[Alpha:D] $str where { .elems == 3 }
--> List:D[Alpha:D]
)
#-------------------------------------------------------------------------------
{
    my Alpha  @substrs;
    my Alpha ($s1, $s2, $s3) = $str.sort:
                               { $^a.chars <=> $^b.chars || $^a leg $^b };
    my Alpha  @candidates    = find-candidates( $s1 );

    for @candidates -> Alpha $candidate
    {
        my UInt $cand-len = $candidate.chars;

        last if @substrs.elems > 0 && @substrs[0].chars > $cand-len;

        for 0 .. $cand-len - 1 -> UInt $i
        {
            for ($i + 1 .. $cand-len).reverse -> UInt $j
            {
                my Alpha $substr = $candidate.substr: $i, $j - $i;

                record-substr( @substrs, $substr )
                    if $s2 ~~ / $substr / && $s3 ~~ / $substr /;
            }
        }
    }

    return @substrs .= sort: { $^a leg $^b };
}

#-------------------------------------------------------------------------------
sub find-candidates( Alpha:D $s1 --> List:D[Alpha:D] )
#-------------------------------------------------------------------------------
{
    my Alpha $pattern = S:g/ (.) /{ $0 eq @VOWELS.any ?? 'V' !! 'C' }/
                        given $s1;
    my Alpha @candidates;
    my Match @matches = m:g/ C? [VC]* V? / given $pattern;

    for @matches
    {
        @candidates.push: $s1.substr( .from, .to - .from ) if .chars > 0;
    }

    return @candidates .= sort: { $^b.chars <=> $^a.chars || $^a leg $^b };
}

#-------------------------------------------------------------------------------
sub record-substr( List:D[Alpha:D] $substrs, Alpha:D $substr )
#-------------------------------------------------------------------------------
{
    if $substrs.elems == 0
    {
        $substrs.push: $substr;
    }
    else
    {
        my UInt $sub-len = $substr.chars;
        my UInt $max-len = $substrs[0].chars;

        if    $sub-len >  $max-len
        {
            @$substrs = $substr;
        }
        elsif $sub-len == $max-len
        {
            $substrs.push: $substr;
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
        my Str ($test-name, $str1, $str2, $str3,  @exp-strs) = $line.split: '|';

        for     $test-name, $str1, $str2, $str3, |@exp-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Alpha  @str      = $str1, $str2, $str3;
        my Alpha  @substr   = find-longest-substrs( @str );
        my Alpha  @expected = @exp-strs;

        is-deeply @substr, @expected, $test-name;
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
        Example 1       |relocate    |delocate   |allocate  |locate
        Example 2       |apple       |banana     |cherry
        Example 3       |navigate    |cavity     |gravity   |avi
        Example 4       |pedalgia    |pedalboard |pedantic  |peda
        Example 5       |schoolmaster|schoolhouse|schooling |ho    |ol
        2 sub-candidates|ababcdededed|edededabab |ababededed|ededed
        END
}

################################################################################
