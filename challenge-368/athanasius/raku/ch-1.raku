use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 368
=========================

TASK #1
-------
*Make it Bigger*

Submitted by: Mohammad Sajid Anwar

You are given [...] a string number and a character digit.

Write a script to remove exactly one occurrence of the given character digit
from the given string number, [so that the] resulting [number in its ] [...]
decimal form is maximised.

Example 1

  Input: $str = "15456", $char = "5"
  Output: "1546"

  Removing the second "5" is better because the digit following it (6) is
  greater than 5. In the first case, 5 was followed by 4 (a decrease), which
  makes the resulting number smaller.

Example 2

  Input: $str = "7332", $char = "3"
  Output: "732"

Example 3

  Input: $str = "2231", $char = "2"
  Output: "231"

  Removing either "2" results in the same string here. By removing a "2", we
  allow the "3" to move up into a higher decimal place.

Example 4

  Input: $str = "543251", $char = "5"
  Output: "54321"

  If we remove the first "5", the number starts with 4. If we remove the second
  "5", the number still starts with 5. Keeping the largest possible digit in the
  highest place value is almost always the priority.

Example 5

  Input: $str = "1921", $char = "1"
  Output: "921"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. The input $str can be any string representing a real number.
2. The input string must contain at least one occurrence of the digit $char.
3. There are cases in which valid input produces no valid output (e.g., if $str
   and $char are both "1").

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string representing a real number is entered on the command-line, followed
   by a digit contained in the string.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 368, Task #1: Make it Bigger (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str  where { +$str ~~ Real:D },                   #= A real number
    Str:D $char where { / ^ \d $ / && $str ~~ / $char / }    #= A digit in <str>
)
#===============================================================================
{
    qq[Input:  \$str = "$str", \$char = "$char"].put;

    my Str $new-num = remove-digit( $str, $char );

    "Output: %s\n".printf: $new-num.defined ?? qq["$new-num"] !! '<none>';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub remove-digit
(
    Str:D $str  where { +$str ~~ Real:D },
    Str:D $char where { / ^ \d $ / && $str ~~ / $char / }
--> Str:_
)
#-------------------------------------------------------------------------------
{
    my Str @candidates;
    my Str @chars = $str.split: '', :skip-empty;

    for 0 .. @chars.end -> UInt $i
    {
        if @chars[$i] eq $char
        {
            my Str $reduced  = @chars[0      .. $i - 1    ].join;
                   $reduced ~= @chars[$i + 1 .. @chars.end].join;

            @candidates.push: $reduced;
        }
    }

    # Remove empty strings as they numify to zero; also remove strings like "."
    # that do not numify at all

    @candidates = @candidates.grep: { .chars && +$_ ~~ Real };

    return @candidates.elems ?? @candidates.max( { +$_ } ) !! Nil;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $str, $char, $expected) = $line.split: / \| /;

        for     $test-name, $str, $char, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $new-num = remove-digit( $str, $char ) // '<none>';

        is $new-num, $expected, $test-name;
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
        Example 1   |   15456|5|   1546
        Example 2   |    7332|3|    732
        Example 3   |    2231|2|    231
        Example 4   |  543251|5|  54321
        Example 5   |    1921|1|    921
        One digit   |       4|4| <none>
        Negative    |   -1921|1|   -192
        Decimal 1   |      .1|1| <none>
        Decimal 2   |     .22|2|    .2
        Decimal 3   |   -3.33|3|   -.33
        E notation 1| 404e04 |4|  40e04
        E notation 2| 505e-51|5| 505e-1
        E notation 3|-606e+56|6|-606e+5
        END
}

################################################################################
