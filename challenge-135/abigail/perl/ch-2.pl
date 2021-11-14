#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';
use experimental 'regex_sets';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# Map characters to their value.
#
my %c = do {my $c = 0; map {$_ => $c ++} 0 .. 9, 'A' .. 'Z'};

#
# Perform the following checks:
#   - All characters are either digits, or capital letters, excluding vowels
#         + ASCII digits and letters
#         + Y is not a vowel
#   - We have exactly 7 of them.
#   - We have the correct check digit
#
# ((?[[0-9A-Z]-[AEIOU]])) matches any digit or upper case ASCII character,
#                         except vowels; this is capture group 1.
#     ((?1)):             use the same subpattern as capture group 1,
#                         and capture it.
# @{["((?1))" x 5]}:      repeat the above 5 times.
# [0-9]:                  last character must be digit
#
say /^((?[[0-9A-Z]-[AEIOU]]))@{["((?1))" x 5]}([0-9])$/x &&
($c {$1} + 3 * $c {$2} + $c {$3} + 7 * $c {$4} + 3 * $c {$5} + 9 * $c {$6} +
 $c {$7}) % 10 == 0 || 0 while <>;
