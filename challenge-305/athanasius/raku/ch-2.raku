use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 305
=========================

TASK #2
-------
*Alien Dictionary*

Submitted by: Mohammad Sajid Anwar

You are given a list of words and alien dictionary character order.

Write a script to sort lexicographically the given list of words based on the
alien dictionary characters.

Example 1

  Input: @words = ("perl", "python", "raku")
         @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
  Output: ("raku", "python", "perl")

Example 2

  Input: @words = ("the", "weekly", "challenge")
         @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
  Output: ("challenge", "the", "weekly")

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The alien dictionary comprises a subset of the printable ASCII character set,
   and may include upper- and lower-case letters, digits, and punctuation, but
   not the space or tab characters.
2. Sorting is case-sensitive. For example, if "A" and "a" both appear in the
   list of words to be sorted, they must have separate entries in the alien
   dictionary.
3. Duplicate characters in the alien dictionary are ignored; only the first such
   character is used in establishing the lexicographical order.
4. The words to be sorted must be composed entirely of characters in the alien
   dictionary.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string comprising the alien dictionary is entered on the command-line,
   followed by a non-empty list of words to be sorted. Whitespace within the
   alien dictionary string is optional, and will be ignored.

=end comment
#===============================================================================

use Test;

subset Char of Str where { / ^ \S $ / };

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 305, Task #2: Alien Dictionary (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $alien,                     #= A string comprising an alien dictionary
         *@words where { .elems > 0 } #= A non-empty list of words to be sorted
)
#===============================================================================
{
    my Char @alien = $alien.split( '', :skip-empty ).grep: { $_ ~~ Char:D };

    "Input: \@words = (%s)\n"\ .printf: @words.map( { qq["$_"] } ).join: ', ';
    "       \@alien = qw/%s/\n".printf: @alien.join: ' ';

    my Str @sorted = alien-sort( @alien, @words );

    "Output: (%s)\n".printf: @sorted.map( { qq["$_"] } ).join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub alien-sort( List:D[Char:D] $alien, List:D[Str:D] $words --> Seq:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my UInt $index = 1;
    my UInt %char-dict{Char};
            %char-dict{ $_ }:exists or %char-dict{ $_ } = $index++ for @$alien;

    my Str  $alt     = $alien.join: '|';
    my UInt $max-len = $words.map( { .chars } ).max;
    my UInt %word-dict{Str};

    for @$words -> Str $word
    {
        $word ~~ / ^ [ <{ $alt }> ]+ $ / or
            error( qq[Invalid character found in word "$word"] );

        my Str $score  = '';
               $score ~= '%03s'.sprintf: %char-dict{ $_ }
                                               for $word.split: '', :skip-empty;
               $score ~= '000' for 1 .. $max-len - $word.chars;

        %word-dict{ $word } = $score.Int;
    }

    return $words.sort: { %word-dict{ $^a } <=> %word-dict{ $^b } };
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $words-str, $alien-str, $exptd-str) =
                $line.split: / \| /;

        for     $test-name, $words-str, $alien-str, $exptd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Char @alien    = $alien-str.split( '', :skip-empty )\
                                      .grep: { $_ ~~ Char:D };
        my Str  @words    = $words-str.split: / \s+ /, :skip-empty;
        my Str  @expected = $exptd-str.split: / \s+ /, :skip-empty;
        my Str  @sorted   = alien-sort( @alien, @words );

        is-deeply @sorted, @expected, $test-name;
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
    my Str $data = q:to/END/;
        Example 1|perl python raku    |hlabydefgirkmnopqjstuvwxcz              \
                 |raku python perl
        Example 2|the weekly challenge|corldabtefghijkmnpqswuvxyz              \
                 |challenge the weekly
        Lengths  |butte but butter    |rtube                                   \
                 |but butte butter
        END

    return S:g/ \s* \\ \n \s* // given $data;
}

################################################################################
