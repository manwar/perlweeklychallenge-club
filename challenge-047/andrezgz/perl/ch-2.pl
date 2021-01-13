#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-047/
# Task #2
#
# Gapful Number
# Write a script to print first 20 Gapful Numbers greater than or equal to 100.
# Please check out the page for more information about Gapful Numbers.
# https://oeis.org/A108343
#  Gapful numbers >= 100: numbers that are divisible by the number formed by their first and last digit.
#  Numbers up to 100 trivially have this property and are excluded.

use strict;
use warnings;

my $n = 99;
my $gapfuls = 0;

while ($gapfuls < 20) {
    print $n.$/ if ++$n % ( substr($n, 0, 1) . substr($n, -1) ) == 0 && $gapfuls++;
}

__END__

./ch-2.pl
105
108
110
120
121
130
132
135
140
143
150
154
160
165
170
176
180
187
190
