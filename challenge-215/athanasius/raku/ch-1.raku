use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 215
=========================

TASK #1
-------
*Odd One Out*

Submitted by: Mohammad S Anwar

You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the
number of words in the list that are not alphabetically sorted.

Example 1

  Input: @words = ('abc', 'xyz', 'tsu')
  Output: 1

  The words 'abc' and 'xyz' are sorted and can't be removed.
  The word 'tsu' is not sorted and hence can be removed.

Example 2

  Input: @words = ('rat', 'cab', 'dad')
  Output: 3

  None of the words in the given list are sorted.
  Therefore all three needs to be removed.

Example 3

  Input: @words = ('x', 'y', 'z')
  Output: 0

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True (the default), the output is followed by a break-
   down of the sorted and unsorted words.

Assumptions
-----------
1. "Alphabetic characters" are A-Z and a-z only.
2. "Sorted alphabetically" means sorted in monotonically ascending alphabetical
   order.
3. Treatment of uppercase letters:
   a. If the constant "ASCIIBETICAL" is set to True, uppercase letters rank
      below lowercase letters; so, e.g., "Bade" IS alphabetically sorted.
   b. Otherwise (the default), each uppercase letter is considered identical to
      its lowercase counterpart; so, "Bade" is equivalent to "bade", which is
      NOT alphabetically sorted.

=end comment
#===============================================================================

use Test;

my Bool constant ASCIIBETICAL = False;
my Bool constant VERBOSE      = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 215, Task #1: Odd One Out (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Non-empty list of same-size words (chars A-Z and a-z only)

    *@words where { .elems > 0 && @words[ 0 ].chars == .all.chars }
)
#===============================================================================
{
    "Input:  \@words = (%s)\n".printf: @words.map( { qq['$_'] } ).join: ', ';

    my Array[Str] ($sorted, $unsorted) = partition( @words );

    'Sorting ASCIIbetically...'.put if ASCIIBETICAL;

    "Output: %d\n"\.printf: $unsorted.elems;

    if VERBOSE
    {
        "\nSorted:   (%s)\n".printf: $sorted.map( { qq['$_'] } ).join: ', ';
        "Unsorted: (%s)\n".printf: $unsorted.map( { qq['$_'] } ).join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub partition( Array:D[Str:D] $words --> List:D[List:D[Str:D], List:D[Str:D]] )
#-------------------------------------------------------------------------------
{
    my Str (@sorted, @unsorted);

    for @$words -> Str $word
    {
        my Bool $sorted   = True;
        my Str  $previous = '';

        for $word.split: '', :skip-empty
        {
            my Str $letter = ASCIIBETICAL ?? $_ !! .lc;

            if $letter lt $previous
            {
                $sorted = False;
                last;
            }

            $previous = $letter;
        }

        ($sorted ?? @sorted !! @unsorted).push: $word;
    }

    return @sorted, @unsorted;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words, $expected) = $line.split: / \| /;

        if ASCIIBETICAL && $test-name ~~ / case /
        {
            skip 'This test requires "ASCIIBETICAL" to be False';
        }
        else
        {
            s/ \s+ $ // for $test-name, $words;        # Trim whitespace

            my Str         @words              = $words.split: ',';
            my Array[Str] ($sorted, $unsorted) = partition( @words );

            is $unsorted.elems, $expected.Int, $test-name;
        }
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
        Example 1 |abc,xyz,tsu                 |1
        Example 2 |rat,cab,dad                 |3
        Example 3 |x,y,z                       |0
        Repeats   |beet,allow,abbot,boot,redder|1
        Capitals  |ABC,XYZ,TSU                 |1
        Mixed case|Bade,abcd,Abcd              |1
        END
}

################################################################################
