#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( max );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> <char>
  perl $0

    <str>     A real number
    <char>    A digit in <str>
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 368, Task #1: Make it Bigger (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my ($str, $char) = @ARGV;

        $str  =~ / ^ $RE{num}{real} $ /x
                            or error( qq["$str" is not a valid real number] );
        $char =~ / ^ [0-9] $ /x
                            or error( qq["$char" is not a valid digit] );
        $str  =~ / $char /x or error( qq["$str" does not contain "$char"] );

        print qq[Input:  \$str = "$str", \$char = "$char"\n];

        my $new_num = remove_digit( $str, $char );

        printf "Output: %s\n", defined $new_num ? qq["$new_num"] : '<none>';

    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub remove_digit
#-------------------------------------------------------------------------------
{
    my ($str, $char) = @_;
    my  @candidates;
    my  @chars = split //, $str;

    for my $i (0 .. $#chars)
    {
        if ($chars[$i] eq $char)
        {
            my $reduced  = join '', @chars[0      .. $i - 1 ];
               $reduced .= join '', @chars[$i + 1 .. $#chars];

            push @candidates, $reduced;
        }
    }

    # Remove strings like "" or "." that do not numify

    @candidates = grep { / ^ $RE{num}{real} $ /x } @candidates;

    return scalar @candidates ? max @candidates : undef;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $char, $expected) = split / \| /x, $line;

        for ($test_name, $str, $char, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $new_num = remove_digit( $str, $char ) // '<none>';

        is $new_num, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
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
