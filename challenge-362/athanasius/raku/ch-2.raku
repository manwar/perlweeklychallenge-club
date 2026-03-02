use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 362
=========================

TASK #2
-------
*Spellbound Sorting*

Submitted by: Peter Campbell Smith

You are given an array of integers.

Write a script to return them in alphabetical order, in any language of your
choosing. Default language is English.

Example 1

  Input: (6, 7, 8, 9 ,10)
  Output: (8, 9, 7, 6, 10)

  eight, nine, seven, six, ten

Example 2

  Input: (-3, 0, 1000, 99)
  Output: (-3, 99, 1000, 0)

  minus three, ninety-nine, one thousand, zero

Example 3

  Input: (1, 2, 3, 4, 5)

  Output: (5, 2, 4, 3, 1) for French language
  cinq, deux, quatre, trois, un

  Output: (5, 4, 1, 3, 2) for English language
  five, four, one, three, two

Example 4

  Input: (0, -1, -2, -3, -4)
  Output: (-4, -1, -3, -2, 0)

  minus four, minus one, minus three, minus two, zero

Example 5

  Input: (100, 101, 102)
  Output: (100, 101, 102)

  one hundred, one hundred and one, one hundred and two

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
2. A language is optionally entered as a named argument, e.g., --lang=French. If
   this is omitted, the language defaults to English.
3. A list of one or more integers is entered on the command-line.
4. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Lingua::EN::Numbers;
use Test;

subset Result of List where (Array[Int], Array[Str]);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 362, Task #2: Spellbound Sorting (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$lang = 'English',                           #= Language
          *@ints where { .elems > 0 && .all ~~ Int:D }  #= A list of 1+ integers
)
#===============================================================================
{
    "Language: $lang".put;

    $lang eq 'English'
        or error( qq[Sorry, language "$lang" is not yet supported] );

    "Input:   (%s)\n".printf: @ints.join: ', ';

    my Result $result = spellbound-sort( $lang, @ints );

    "Output:  (%s)\n".printf: $result[0].join: ', ';
    "          %s\n"\.printf: $result[1].join: ', '
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub spellbound-sort( Str:D $lang, List:D[Int:D] $ints --> Result:D )
#-------------------------------------------------------------------------------
{
    my Str %num2name{Int};

    for @$ints -> Int $int
    {
        %num2name{$int.Int} = cardinal( $int ) unless %num2name{$int}:exists;
    }

    for %num2name.keys -> Int $int
    {
        %num2name{$int} ~~ s/ ^ negative /minus/;
        %num2name{$int} ~~ s:g/ (hundred||thousand) <-[,]> /$0 and /;
        %num2name{$int} ~~ s:g/ \, //;
    }

    my Int @sorted = $ints.sort:  { %num2name{$^a.Int} leg %num2name{$^b.Int} };
    my Str @names  = @sorted.map: { %num2name{$_.Int} };

    return @sorted, @names;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $lang, $inp-ints-str, $exp-ints-str,  @exp-text) =
                $line.split: / \| /;

        for     $test-name, $lang, $inp-ints-str, $exp-ints-str, |@exp-text
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int    @inp-ints = $inp-ints-str.split( / \s+ /, :skip-empty )
                                           .map: { .Int };
        my Result $result   = spellbound-sort( $lang ||= 'English', @inp-ints );
        my Int    @exp-ints = $exp-ints-str.split( / \s+ /, :skip-empty )
                                           .map: { .Int };

        is-deeply $result[0], @exp-ints, "$test-name: integers";
        is-deeply $result[1], @exp-text, "$test-name: words";
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit 0;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $data = q:to/END/;
        Example 1 ||6 7 8 9 10|8 9 7 6 10|eight|nine|seven|six|ten
        Example 2 ||-3 0 1000 99|-3 99 1000 0|minus three|ninety-nine|         \
                    one thousand|zero
        Example 3b||1 2 3 4 5|5 4 1 3 2|five|four|one|three|two
        Example 4 ||0 -1 -2 -3 -4|-4 -1 -3 -2 0|minus four|minus one|          \
                    minus three|minus two|zero
        Example 5 ||100 101 102|100 101 102|one hundred|one hundred and one|   \
                    one hundred and two
        END

    return S:g/ \\ \n // given $data;

#       Example 3a|French|1 2 3 4 5|5 2 4 3 1|cinq|deux|quatre|trois|un
}

################################################################################
