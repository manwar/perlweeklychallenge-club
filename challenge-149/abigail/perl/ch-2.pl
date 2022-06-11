#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: perl ch-2.pl < input-file
#

#
# This sequence A287298 in the OEIS.
#
# It's worrysome that the OEIS only lists entries up to n = 22 (while
# skipping n = 21). 
#
# And if we look at the given Python program to generate the entries,
# we see it's very slow: it starts with the largest number in base b
# where all the digits are distinct, of which it takes the integer
# square root. This is m. We then square m, getting m2. If all the digits
# of m2 are different, we done. Else, we keep decrementing m by 1 and
# repeat the process till we have an m2 of which all the digits are
# different.
#
# This is *extremely slow* unless n is small.
#
# Therefore, we will not repeat this calculation. Instead, we will
# just use a loopup table, using the values from
# https://oeis.org/A287298/b287298.txt.
#
# This lookup table was created by ../data/preprocess:
#   - We fetch the values from https://oeis.org/A287298/b287298.txt,
#     and inject the value for base = 22
#   - We add values for bases 23, 24, and 25, derived from running the
#     OEIS supplied Python program for quite some time.
#   - We then use bc to translate the decimal numbers to the
#     appropriate base.
#   - For bases exceeding 16, bc doesn't use letters, but numbers;
#     we use a regexp to fix those.
#

my @A287298;

$A287298 [ 2] =                         "1";
$A287298 [ 3] =                         "1";
$A287298 [ 4] =                      "3201";
$A287298 [ 5] =                      "4301";
$A287298 [ 6] =                    "452013";
$A287298 [ 7] =                   "6250341";
$A287298 [ 8] =                  "47302651";
$A287298 [ 9] =                 "823146570";
$A287298 [10] =                "9814072356";
$A287298 [11] =               "A8701245369";
$A287298 [12] =              "B8750A649321";
$A287298 [13] =              "CBA504216873";
$A287298 [14] =            "DC71B30685A924";
$A287298 [15] =           "EDAC93B24658701";
$A287298 [16] =          "FED5B39A42706C81";
$A287298 [17] =          "GFED5A31C6B79802";
$A287298 [18] =        "HGF80ADC53712EB649";
$A287298 [19] =       "IHGFD3408C6E715A2B9";
$A287298 [20] =      "JIHG03DAC457BFE96281";
$A287298 [22] =    "LKJIG5D14B9032FHAC867E";
$A287298 [23] =   "MLKJEFG5IC1D9H8042AB376";
$A287298 [24] =  "NMLKJ2BD0639GFE7C8IH5A41";
$A287298 [25] = "ONMLKD8CJE2H47F6395I0B1AG";

say $A287298 [$_] // "Too hard to calculate" while <>;
