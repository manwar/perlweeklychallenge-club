#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl
#

#
# This is a trivial exercise -- as all exercises are which do not
# take any input, and which have a fixed output.
#
# This exercise is so trivial, we don't even have to head to the OEIS
# to download the wanted numbers. We can easily derive what the
# first numbers are.
#
# Note the following observations for self-descriptive numbers in
# a given base b:
#
#   1) The number has exactly b digits (we don't count leading 0s)
#   2) For all digits d, 0 <= d < b.
#   3) The last digit must be a 0
#   4) The leading digit must be greater than 0.
#   5) No digit can be b - 1.
#   6) The sum of all the digits is b.
#
# From 2) it follows there is no self-descriptive number in base 1.
# From 3) and 4) it follows that if there is a self-descriptive
# number in base 2 it must be "10". But 5) prohibits this.
# From 1) - 5) it follows that any self-descriptive number in base 3
# has be of the form "1.0". From 6), it follows that such a number
# must be "120", but since we don't have two 1's in the number, it
# is not self-descriptive.
# 
# For base 4, the leading digit must be a 1 or a 2. If the first digit
# is a 1, the number is of the form "1ab0", where a != 0, b != 0,
# and a + b == 3. a cannot be 1, as that would imply the number
# contains just one 1, but "1120" contains two 1s. "1210", however,
# is a self-descriptive number, and this is the first self-descriptive
# number. If the first digit is a 2, out of the other three digits,
# two have to be 0 (of which one is the last one), and hence, the
# other has to be 2. The pen-ultimate digit cannot be 0 (as the number
# has at least one 2), leaving us with "2020". And this is self-descriptive.
#
# For base 5, possible leading digits are 1, 2, and 3. 
# If the leading digit is a 1, there can only be one 0, and we know
# this must be the last digit. Which means the next three digits are
# all non-zero, and sum to 4. Which means the next three digits are
# 1, 1, and 2. But that means the number contains four 1s, but the
# number does not contain a 4.
# If the leading digit is a 3, there is only one non-zero in the next
# digits, and this must be a 2. But that leaves no way to describe
# the number of 3s.
# If the leading digits is a 2, of the next four numbers, two are 0
# (including the last one), and two are non-zero. Those two non-zero
# numbers must add to 3, which means they are 1 and 2. This means the
# third digit (describing the number of 2s) must be 2, and the second
# digit (describing the number of 1s), must be 1. And "21200" is a 
# self-describing number.
#
# Which means, we now have the first three self-describing numbers:
#    "1210", "2020", "21200".
#

say "1210, 2020, 21200";
