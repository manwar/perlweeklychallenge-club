use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 265
=========================

TASK #2
-------
*Completing Word*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str containing alphnumeric characters and array of
strings (alphabetic characters only), @str.

Write a script to find the shortest completing word. If none found return empty
string.

    A completing word is a word that contains all the letters in the given
    string, ignoring space and number. If a letter appeared more than once in
    the given string then it must appear the same number or more in the word.

Example 1

  Input: $str = 'aBc 11c'
         @str = ('accbbb', 'abc', 'abbc')
  Output: 'accbbb'

  The given string contains following, ignoring case and number:
  a 1 times
  b 1 times
  c 2 times

  The only string in the given array that satisfies the condition is 'accbbb'.

Example 2

  Input: $str = 'Da2 abc'
         @str = ('abcm', 'baacd', 'abaadc')
  Output: 'baacd'

  The given string contains following, ignoring case and number:
  a 2 times
  b 1 times
  c 1 times
  d 1 times

  The are 2 strings in the given array that satisfies the condition:
  'baacd' and 'abaadc'.

  Shortest of the two is 'baacd'

Example 3

  Input: $str = 'JB 007'
         @str = ('jj', 'bb', 'bjb')
  Output: 'bjb'

  The given string contains following, ignoring case and number:
  j 1 times
  b 1 times

  The only string in the given array that satisfies the condition is 'bjb'.

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
2. The string $str is entered as a named argument on the command-line.
3. Strings of the list @str are entered as unnamed arguments on the command-
   line.

Assumptions
-----------
1. From the Examples, it appears that case is ignored when searching for a com-
   pleting word.
2. If there are two or more shortest completing words, choose the first (lowest)
   by ascending alphabetical order.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 265, Task #2: Completing Word (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| String of alphnumeric chars and/or whitespace

    Str:D :$str  where { $str ~~ / ^ <[ \w \s ] - [ _ ]>* $ / },

    #| List of strings of alphabetic characters only

          *@strs where { .all ~~ / ^ <[ a .. z A .. Z ]>* $ / }
)
#===============================================================================
{
    "Input:  \$str  = '$str'".put;
    "        \@strs = (%s)\n".printf: @strs.map( { "'$_'" } ).join: ', ';

    my Str $word = find-completing-word( $str, @strs );

    "Output: '$word'".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-completing-word( Str:D $str, List:D[Str:D] $strings --> Str:D )
#-------------------------------------------------------------------------------
{
    my UInt %required;

    for $str.split( '', :skip-empty ) -> Str $char
    {
        ++%required{ $char.lc } if $char ~~ / ^ <.alpha> $ /;
    }

    my Str @candidates;

    L-STRINGS: for @$strings -> Str $string
    {
        my UInt %chars;
              ++%chars{ .lc } for $string.split: '', :skip-empty;

        for %required<>:k -> Str $key
        {
            next L-STRINGS unless %chars{ $key }:exists &&
                                  %chars{ $key } >= %required{ $key };
        }

        @candidates.push: $string;
    }

    @candidates .= sort: { .chars, .Str };

    return @candidates.elems > 0 ?? @candidates[ 0 ] !! '';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $strs-str, $expected) = $line.split: / \| /;

        for     $test-name, $str, $strs-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @str  = $strs-str.split: / \s+ /, :skip-empty;
        my Str $word = find-completing-word( $str, @str );

        is $word, $expected, $test-name;
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
        Example 1|aBc 11c|accbbb abc    abbc  |accbbb
        Example 2|Da2 abc|abcm   baacd  abaadc|baacd
        Example 3|JB 007 |jj     bb     bjb   |bjb
        Sort     |Da2 abc|abcm   baacdf baacde|baacde
        None     |Abcd 4f|abc    df     acf   |
        END
}

################################################################################
