use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 370
=========================

TASK #1
-------
*Popular Word*

Submitted by: Mohammad Sajid Anwar

You are given a string paragraph and an array of the banned words.

Write a script to return the most popular word that is not banned. It is guaran-
teed there is at least one word that is not banned and the answer is unique. The
words in paragraph are case-insensitive and the answer should be in lowercase.
The words can not contain punctuation symbols.

Example 1

  Input: $paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
         @banned = ("hit")
  Output: "ball"

  After removing punctuation and converting to lowercase, the word "hit" appears
  3 times, and "ball" appears 2 times.
  Since "hit" is on the banned list, we ignore it.

Example 2

  Input: $paragraph = "Apple? apple! Apple, pear, orange, pear, apple, orange."
         @banned = ("apple", "pear")
  Output: "orange"

  "apple"  appears 4 times.
  "pear"   appears 2 times.
  "orange" appears 2 times.

  "apple" and "pear" are both banned.
  Even though "orange" has the same frequency as "pear", it is the only non-
  banned word with the highest frequency.

Example 3

  Input: $paragraph = "A. a, a! A. B. b. b."
         @banned = ("b")
  Output: "a"

  "a" appears 4 times.
  "b" appears 3 times.

  The input has mixed casing and heavy punctuation.
  The normalised, "a" is the clear winner, since "b" is banned, "a" is the only
  choice.

Example 4

  Input: $paragraph = "Ball.ball,ball:apple!apple.banana"
         @banned = ("ball")
  Output: "apple"

  Here the punctuation acts as a delimiter.
  "ball"   appears 3 times.
  "apple"  appears 2 times.
  "banana" appears 1 time.

Example 5

  Input: $paragraph = "The dog chased the cat, but the dog was faster than the
                       cat."
         @banned = ("the", "dog")
  Output: "cat"

  "the" appears 4 times.
  "dog" appears 2 times.
  "cat" appears 2 times.

  "chased", "but", "was", "faster", "than" appear 1 time each.
  "the" is the most frequent but is banned.
  "dog" is the next most frequent but is also banned.
  The next most frequent non-banned word is "cat".

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. If a paragraph word is hyphenated, it is treated as two separate words. For
   example, "co-exist" is treated as "co" and "exist".
2. If a banned word contains uppercase letters, they are converted to lowercase.
3. If a banned word contains non-alphabetic characters, they are removed (other-
   wise it would have no effect, since paragraph words cannot contain non-alpha-
   betic characters and so could never match).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A paragraph string is entered on the command-line, followed by a list of
   banned words.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 370, Task #1: Popular Word (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $paragraph,                                  #= A string paragraph
         *@banned where { .all ~~ Str:D }              #= A list of banned words
)
#===============================================================================
{
    qq[Input:  \$paragraph =  "$paragraph"].put;
    qq[        \@banned    = (%s)\n].printf:
                @banned.map( { qq["$_"] } ).join: ', ';

    my Str $popular = find-popular-word( $paragraph, @banned );

    "Output: %s\n".printf: $popular.defined ?? qq["$popular"] !! '<none>';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-popular-word( Str:D $paragraph, List:D[Str:D] $banned --> Str )
#-------------------------------------------------------------------------------
{
    my Str  @words  = $paragraph.split: / <-[ A..Z a..z ]>+ /, :skip-empty; 
            @words  = @words\.map: { .lc };
    my Str  @banned = $banned.map: { .lc };
    my UInt %dict;

    s:g/ <-[ A..Z a..z ]> // for @banned;

    for @words -> Str $word
    {
        ++%dict{$word} unless $word ∈ @banned;
    }

    my Str $popular;

    if %dict.elems > 0
    {
        my UInt $max-freq     = %dict.values.max;
        my Str  @most-popular = %dict.keys.grep: { %dict{$_} == $max-freq };

        # "It is guaranteed there is at least one word that is not banned and
        #  the answer is unique."

        $popular = @most-popular[0] if @most-popular.elems == 1;
    }

    return $popular;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $paragraph, $banned-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $paragraph, $banned-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @banned  = $banned-str.split: / \s+ /, :skip-empty;
        my Str $popular = find-popular-word( $paragraph, @banned ) // '<none>';

        is $popular, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $data = q:to/END/;
        Example 1 |Bob hit a ball, the hit BALL flew far after it was hit.|hit \
                  |ball
        Example 2 |Apple? apple! Apple, pear, orange, pear, apple, orange.     \
                  |apple pear|orange
        Example 3 |A. a, a! A. B. b. b.|b|a
        Example 4 |Ball.ball,ball:apple!apple.banana|ball|apple
        Example 5 |The dog chased the cat, but the dog was faster than the cat.\
                  |the dog|cat
        All banned|The DOG chased the cat, the bird watched.|bird but cat      \
                   chased dog the watched|<none>
        Not unique|Perl Raku C||<none>
        END

    return S:g/ \\ \n \s* // given $data;
}

################################################################################
