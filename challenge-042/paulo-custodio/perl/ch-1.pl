#!/usr/bin/env perl

# Challenge 042
#
# TASK #1
# Octal Number System
# Write a script to print decimal number 0 to 50 in Octal Number System.
#
# For example:
#
# Decimal 0 = Octal 0
# Decimal 1 = Octal 1
# Decimal 2 = Octal 2
# Decimal 3 = Octal 3
# Decimal 4 = Octal 4
# Decimal 5 = Octal 5
# Decimal 6 = Octal 6
# Decimal 7 = Octal 7
# Decimal 8 = Octal 10
# and so on.

use Modern::Perl;
use Math::BaseCnv;

for (0..50) {
    say "Decimal $_ = Octal ",cnv($_,10,8);
}
