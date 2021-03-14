#!perl

###############################################################################
=comment

Perl Weekly Challenge 103
=========================

Task #1
-------
*Chinese Zodiac*

Submitted by: Mohammad S Anwar

You are given a year $year.

Write a script to determine the Chinese Zodiac for the given year $year. Please
check out [ https://en.wikipedia.org/wiki/Chinese_zodiac |wikipage] for more
information about it.

The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
Rooster, Dog, Pig.
The element cycle: Wood, Fire, Earth, Metal, Water.

Example 1:

     Input: 2017
     Output: Fire Rooster

Example 2:

     Input: 1938
     Output: Earth Tiger

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
1. Years are AD (= CE), Gregorian calendar, only.
2. Each year begins on Chinese New Year. For example, "1954" actually begins on
   5th February, 1954, and ends on 23rd January, 1955.

Algorithm
---------
The Chinese lunar calendar is a sexagenary (60 year) cycle comprising two
lesser cycles: a 12-year cycle of animal signs and a 10-year cycle in which
each of 5 elements is repeated for 2 consecutive years.

Given any "start year" (i.e., a year on which the sexagenary cycle begins, with
animal sign Rat and element Wood) such as 1924 or 1984, the animal sign's
index (zero-based) is calculated by finding the difference between the given
year and the start year, then calculating that difference modulus 12. For
example, 2017 - 1984 = 33, and 33 mod 12 = 9, so the animal sign for 2017 is
the tenth in the series, namely Rooster.

The element calculation is similar except that elements change biennially, so
the difference must first be halved (and the remainder, if any, discarded)
before the index is calculated as halved-difference modulus 5. Using 2017 again
as an example, floor(33 / 2) = 16, and 16 mod 5 = 1, so the element for 2017 is
the second in the series, namely Fire.

Note that Perl's modulus operator produces the correct result for negative
differences. From perlop: "If $n is positive, then $m % $n is $m minus the
largest multiple of $n less than or equal to $m." So for (1938 - 1984) = -46,
-46 % 12 = -46 - -48 = 2, which is the same result as would be obtained if the
"start year" were 1924: 1938 - 1924 = 14, and 14 mod 12 = 2.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my @ELEMENTS   => qw( Wood  Fire Earth  Metal   Water );
const my @ANIMALS    => qw( Rat   Ox   Tiger  Rabbit  Dragon Snake
                            Horse Goat Monkey Rooster Dog    Pig );
const my $START_YEAR => 1984;
const my $USAGE      =>
"Usage:
  perl $0 <year>

    <year>    Year AD (positive integer)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 103, Task #1: Chinese Zodiac (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $year = parse_command_line();

    print  "Input:  $year\n";

    my $el_index = int( ($year - $START_YEAR) / 2 ) % scalar @ELEMENTS;
    my $an_index =      ($year - $START_YEAR)       % scalar @ANIMALS;

    printf "Output: %s %s\n", $ELEMENTS[ $el_index ], $ANIMALS[ $an_index ];
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command-line argument, found $args" );

    my $year =  $ARGV[ 0 ];
       $year =~ / ^ $RE{num}{int} $ /x && $year > 0
                  or error( qq["$year" is not a positive integer] );

    return $year;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
