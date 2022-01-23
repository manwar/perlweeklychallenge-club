#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: perl ch-1.pl
#

#
# This is sequence A006933 in the OEIS
#

#
#   Number       English       Contains e
#     0             ZERO            Y
#     1              ONE            Y
#     2              TWO            N
#     3            THREE            Y
#     4             FOUR            N
#     5             FIVE            Y
#     6              SIX            N
#     7            SEVEN            Y
#     8            EIGHT            Y
#     9             NINE            Y
#    10              TEN            Y
#    11           ELEVEN            Y
#    12           TWELVE            Y
#    1?            *TEEN            Y
#    2?          TWENTY*            Y
#    3?          THIRTY*            N
#    4?           FORTY*            N
#    5?           FIFTY*            N
#    6?           SIXTY*            N
#    7?         SEVENTY*            Y
#    8?          EIGHTY*            Y
#    9?          NINETY*            Y
#   100          HUNDRED            Y
#

#
# So, in short, numbers <= 100 containing an E when written in English
# are:  - 0
#       - contains a 1, 7, 8 or 9
#       - ends with a 3, or 5
#       - starts with a 2, and is followed by another digit
#
# Any other numbers are eban.
#

say join " " => grep {!/^0$ | [1789] | ^2. | [35]$/x} 0 .. 100;
