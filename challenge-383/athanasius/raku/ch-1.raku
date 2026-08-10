use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 383
=========================

TASK #1
-------
*Similar List*

Submitted by: Mohammad Sajid Anwar

You are given three list of strings.

Write a script to find out if the first two list are similar with the help the
third list. The third list contains the similar words map.

Example 1

  Input: $list1 = ("great", "acting")
         $list2 = ("fine", "drama")
         $list3 = (["great", "fine"], ["acting", "drama"])
  Output: true

Example 2

  Input: $list1 = ("apple", "pie")
         $list2 = ("banana", "pie")
         $list3 = (["apple", "peach"], ["peach", "banana"])
  Output: false

Example 3

  Input: $list1 = ("perl4", "python")
         $list2 = ("raku", "python")
         $list3 = (["perl4", "perl5", "raku"])
  Output: true

Example 4

  Input: $list1 = ("enjoy", "challenge")
         $list2 = ("love", "weekly", "challenge")
         $list3 = (["enjoy", "love"])
  Output: false

Example 5

  Input: $list1 = ("fast", "car")
         $list2 = ("quick", "vehicle")
         $list3 = (["quick", "fast"], ["vehicle", "car"])
  Output: true

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
2. Two or more strings are entered on the command-line. Each string contains a
   list of words separated by whitespace.

Assumptions
-----------
1. Two lists are similar if and only if they have similar words in the same
   positions within the lists. Corollary: to be similar, lists must contain the
   same number of words.
2. Word comparisons are case-sensitive.
3. Similarity is not transitive. This is counter-intuitive, but Example 2 shows
   that if "apple" is similar to "peach", and "peach" is (separately) similar to
   "banana", it does NOT follow that "apple" is similar to "banana".
4. The similar-words map (list3) is optional; if it is omitted, the lists must
   be identical to be considered similar.

=end comment
#===============================================================================

use Test;

subset Lists of List where (Array[Str], Array[Str], Array[Array[Str]]);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 383, Task #1: Similar List (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $list1-str,               #= First  whitespace-separated list of words
    Str:D $list2-str,               #= Second whitespace-separated list of words
         *@list3-strs where { .all ~~ Str:D }          #= Lists of similar words
)
#===============================================================================
{
    my Lists $lists = parse-input( $list1-str, $list2-str, @list3-strs );

    "Input:  \@list1 = (%s)\n".printf: $lists[0].map( { qq["$_"] } ).join: ', ';
    "        \@list2 = (%s)\n".printf: $lists[1].map( { qq["$_"] } ).join: ', ';

    if $lists[2].elems > 0
    {
        "        \@list3 = (%s)\n".printf:
            $lists[2].map( { '[' ~ .map( { qq["$_"] } ).join( ', ' ) ~ ']' } )
                     .join: ', ';
    }

    my $similar = are-similar( |$lists ) ?? 'true' !! 'false';

    "Output: $similar".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub are-similar
(
    List:D[Str:D]         $list1,
    List:D[Str:D]         $list2,
    List:D[List:D[Str:D]] $list3
--> Bool:D
)
#-------------------------------------------------------------------------------
{
    return False unless $list1.elems == $list2.elems;

    # Build a similar-words map

    my Array[Str] %similar-words{Str};

    for @$list3 -> Array[Str] $list
    {
        for @$list -> Str $word
        {
            %similar-words{ $word }.push: |$list.grep: { $_ ne $word };
        }
    }

    L-OUTER: for 0 .. $list1.end -> UInt $i
    {
        my Str $target    = $list1[$i];
        my Str $candidate = $list2[$i];

        next if $candidate eq $target;

        return False unless %similar-words{ $target }:exists;

        for |%similar-words{ $target } -> Str $word
        {
            next L-OUTER if $candidate eq $word;
        }

        return False;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub parse-input( Str:D $list1, Str:D $list2, List:D[Str:D] $list3 --> Lists:D )
#-------------------------------------------------------------------------------
{
    my Str        @list1 = $list1.split: / \s+ /, :skip-empty;
    my Str        @list2 = $list2.split: / \s+ /, :skip-empty;
    my Array[Str] @map;

    for @$list3 -> Str $str
    {
        @map.push: Array[Str].new: $str.split: / \s+ /, :skip-empty;
    }

    return @list1, @list2, @map;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $list1-str, $list2-str, $expected, @list3-strs) =
                $line.split: '|';

        for     $test-name, $list1-str, $list2-str, $expected, @list3-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Lists $lists   = parse-input( $list1-str, $list2-str, @list3-strs );
        my Str   $similar = are-similar( |$lists ) ?? 'true' !! 'false';

        is $similar, $expected, $test-name;
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
        Example 1|great acting   |fine drama           |true |great fine       \
                 |acting drama
        Example 2|apple pie      |banana pie           |false|apple peach      \
                 |peach banana
        Example 3|perl4 python   |raku python          |true |perl4 perl5 raku
        Example 4|enjoy challenge|love weekly challenge|false|enjoy love
        Example 5|fast car       |quick vehicle        |true |quick fast       \
                 |vehicle car
        Identical|Perl Raku C++  |Perl Raku C++        |true
        END

    return S:g/ \s+ \\ \n \s* / / given $data;
}

################################################################################
