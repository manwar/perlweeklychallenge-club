use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

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

Note that Raku's modulus operator produces the correct result for negative
differences. From https://docs.raku.org/routine/$PERCENT_SIGN :-

    $x % $y == $x - floor($x / $y) * $y

So for (1938 - 1984) = -46, -46 % 12 = -46 - floor(-46 / 12) * 12
                                     = -46 - (-4 * 12) = -46 - -48 = 2

which is the same result as would be obtained if the "start year" were 1924:
1938 - 1924 = 14, and 14 mod 12 = 2.

=end comment
#==============================================================================

my constant @ELEMENTS = Array[Str].new( < Wood Fire Earth Metal Water > );

my constant @ANIMALS  = Array[Str].new\
   (
       < Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig >
   );

my UInt constant $START-YEAR = 1984;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 103, Task #1: Chinese Zodiac (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $year where { $year > 0 }       #= Year AD (positive integer)
)
#==============================================================================
{
    "Input:  $year".put;

    my UInt $el-index = floor( ($year - $START-YEAR) / 2 ) % @ELEMENTS.elems;
    my UInt $an-index =        ($year - $START-YEAR)       % @ANIMALS\.elems;

    "Output: %s %s\n".printf: @ELEMENTS[ $el-index ], @ANIMALS[ $an-index ];
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
