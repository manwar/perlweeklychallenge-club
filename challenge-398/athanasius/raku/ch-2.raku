use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 398
=========================

TASK #2
-------
*String Difference*

Submitted by: Mohammad Sajid Anwar

You are given an array of equal length strings.

Write a script to find the difference integer array of each word in the given
array. There will be one word with a different array; return that word.

  Each words[i] can be converted into a difference integer array difference[i]
  of length n - 1 where difference[i][j] = words[i][j+1] - words[i][j]

Example 1

  Input: @words = ("ab", "bc", "cd", "zy")
  Output: "zy"

  "ab" => [1 - 0] = [1]
  "bc" => [2 - 1] = [1]
  "cd" => [3 - 2] = [1]
  "zy" => [24 - 25] = [-1]

Example 2

  Input: @words = ("cba", "fed", "azy")
  Output: "azy"

  "cba" => [1 - 2, 0 - 1] = [-1, -1]
  "fed" => [4 - 5, 3 - 4] = [-1, -1]
  "azy" => [25 - 0, 24 - 25] = [25, -1]

Example 3

  Input: @words = ("pop", "ada", "beb", "cfc")
  Output: "pop"

  "pop" => [14 - 15, 15 - 14] = [-1, 1]
  "ada" => [3 - 0, 0 - 3] = [3, -3]
  "beb" => [4 - 1, 1 - 4] = [3, -3]
  "cfc" => [5 - 2, 2 - 5] = [3, -3]

Example 4

  Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
  Output: "aaba"

  "aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
  "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
  "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
  "aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]

Example 5

  Input: @words = ("aceg", "bdfh", "cegi", "azbz")
  Output: "azbz"

  "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
  "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
  "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
  "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input list must contain at least 3 elements.
2. The Task Description specifies: "There will be one word with a different
   array; return that word." Hence, the input is invalid unless it produces a
   set of difference arrays in which exactly one array differs from all the
   others. However, as this cannot be ascertained until the difference arrays
   have been calculated, it seems better in such a case to return "<none>" as
   the result, rather than to issue an error message for invalid input data.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 3 or more same-length strings, where the length of each string is
   greater than 1, is entered on the command-line.
3. If "-v" is entered as a command-line flag (along with 3 or more same-length
   strings), the standard output is followed by a table of the difference arrays
   for each of the input words.

=end comment
#===============================================================================

use Test;

subset Result of List where (Str, Hash);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 398, Task #2: String Difference (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of 3 or more n-length strings, where n > 1

    *@words where { .elems >= 3 && valid-strings( @words ) },

    Bool :v($verbose) = False           #= Show the difference array?
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq["$_"] } ).join: ', ';

    my (Str $diff-word, Hash $word2diffs) = find-string-differences( @words );

    "Output: %s\n".printf: $diff-word ?? qq["$diff-word"] !! '<none>';

    "\n%s\n".printf: format-diff-array( $word2diffs ) if $verbose;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-string-differences
(
    List:D[Str:D] $words where { .elems > 0 && valid-strings( $words ) }
--> Result:D
)
#-------------------------------------------------------------------------------
{
    my Array[Int] %word2diffs{Str} = find-diffs( $words );
    my Array[Str] %diff2words{Str} = reverse-hash( %word2diffs );

    my Str $diff-word = '';

    if %diff2words.elems == 2
    {
        my Str ($key0, $key1) = %diff2words.keys.sort;

        if    %diff2words{ $key0 }.elems == 1 &&
              %diff2words{ $key1 }.elems >  1
        {
            $diff-word = %diff2words{ $key0 }[0];
        }
        elsif %diff2words{ $key0 }.elems >  1 &&
              %diff2words{ $key1 }.elems == 1
        {
            $diff-word = %diff2words{ $key1 }[0];
        }
    }

    return ($diff-word, %word2diffs);
}

#-------------------------------------------------------------------------------
sub find-diffs
(
    List:D[Str:D] $words where { .elems > 0 && valid-strings( $words ) }
--> Hash:D[List:D[Int:D]]
)
#-------------------------------------------------------------------------------
{
    my Array[Int] %word2diffs{Str};

    for @$words -> Str $word
    {
        if %word2diffs{ $word }:!exists
        {
            my Int @word-diffs;
            my Str @chars = $word.split: '', :skip-empty;

            for 1 .. @chars.end -> Int $i
            {
                @word-diffs.push: @chars[$i].ord - @chars[$i - 1].ord;
            }

            %word2diffs{ $word }.push: |@word-diffs;
        }
    }

    return %word2diffs;
}

#-------------------------------------------------------------------------------
sub reverse-hash( Hash:D[List:D[Int:D]] $word2diffs --> Hash:D[List:D[Str:D]] )
#-------------------------------------------------------------------------------
{
    my Array[Str] %diff2words{Str};

    for $word2diffs.keys -> Str $word
    {
        my Int @diffs = |$word2diffs{ $word };
        my Str $key   =  @diffs.join: '|';

        %diff2words{ $key }.push: $word;
    }

    return %diff2words;
}

#-------------------------------------------------------------------------------
sub valid-strings( List:D[Str:D] $words where { .elems >= 3 } --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool $valid  = True;
    my UInt $length = $words[0].chars;

    if $length > 1
    {
        for 1 .. $words.end -> UInt $i
        {
            if $words[$i].chars !== $length
            {
                $valid = False;
                last;
            }
        }
    }
    else
    {
        $valid = False;
    }

    return $valid;
}

#-------------------------------------------------------------------------------
sub format-diff-array( Hash:D[List:D[Int:D]] $word2diffs --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str  $str     = '';
    my UInt $n-diffs = $word2diffs.keys[0].elems;
    my UInt @widths  = 1 xx $n-diffs;

    for $word2diffs.keys -> Str $word
    {
        my Int @diffs = |$word2diffs{ $word };

        for 0 .. @diffs.end -> UInt $i
        {
            @widths[$i] = (@widths[$i], @diffs[$i].chars).max;
        }
    }

    for $word2diffs.keys.sort -> Str $word
    {
        $str ~= qq{"$word" => [};

        my Int @diffs = |$word2diffs{ $word };
        my Str @diff-strs;

        for 0 .. @diffs.end -> UInt $i
        {
            @diff-strs.push: '%*d'.sprintf: @widths[$i], @diffs[$i];
        }

        $str ~= "%s]\n".sprintf: @diff-strs.join: ', ';
    }

    return $str.chomp;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $exp-result,  @exp-diff-strs) =
                $line.split: '|';

        for     $test-name, $words-str, $exp-result, |@exp-diff-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str        @words  = $words-str.split: / \s+ /, :skip-empty;
        my Result     $result = find-string-differences( @words );
        my Array[Int] %exp-diffs{Str};

        for 0 .. @words.end -> UInt $i
        {
            %exp-diffs{ @words[$i] } = Array[Int].new:
                        @exp-diff-strs[$i].split( / \s+ /, :skip-empty )
                                          .map: { .Int };
        }

        is        $result[0], $exp-result, "$test-name: result";
        is-deeply $result[1], %exp-diffs,  "$test-name: differences";
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
        Example 1 |ab   bc   cd   zy  |zy  | 1      | 1      | 1      |-1
        Example 2 |cba  fed  azy      |azy |-1 -1   |-1 -1   |25 -1
        Example 2a|cba  fed  azy  xxx |    |-1 -1   |-1 -1   |25 -1   | 0   0
        Example 3 |pop  ada  beb  cfc |pop |-1  1   | 3 -3   | 3 -3   | 3  -3
        Example 4 |aaaa zzzz mmmm aaba|aaba| 0  0  0| 0  0  0| 0  0  0| 0   1 -1
        Example 5 |aceg bdfh cegi azbz|azbz| 2  2  2| 2  2  2| 2  2  2|25 -24 24
        END
}

################################################################################
