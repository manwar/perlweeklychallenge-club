#!/usr/bin/perl

# TASK #1
# Octal Number System

# Write a script to print decimal number 0 to 50 in Octal Number System.
# For example:
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

use strict;
use warnings;

my $top = shift @ARGV || 50;
my $holder = 0;

for (0..$top){
    print "dec: $_ -> oct: ". $holder++ . "\n";
    $holder+=2 if 8 == substr $holder, -1;
}

# dec: 0 -> oct: 0
# dec: 1 -> oct: 1
# dec: 2 -> oct: 2
# dec: 3 -> oct: 3
# dec: 4 -> oct: 4
# dec: 5 -> oct: 5
# dec: 6 -> oct: 6
# dec: 7 -> oct: 7
# dec: 8 -> oct: 10
# dec: 9 -> oct: 11
# dec: 10 -> oct: 12
# dec: 11 -> oct: 13
# dec: 12 -> oct: 14
# dec: 13 -> oct: 15
# dec: 14 -> oct: 16
# dec: 15 -> oct: 17
# dec: 16 -> oct: 20
# dec: 17 -> oct: 21
# dec: 18 -> oct: 22
# dec: 19 -> oct: 23
# dec: 20 -> oct: 24
# dec: 21 -> oct: 25
# dec: 22 -> oct: 26
# dec: 23 -> oct: 27
# dec: 24 -> oct: 30
# dec: 25 -> oct: 31
# dec: 26 -> oct: 32
# dec: 27 -> oct: 33
# dec: 28 -> oct: 34
# dec: 29 -> oct: 35
# dec: 30 -> oct: 36
# dec: 31 -> oct: 37
# dec: 32 -> oct: 40
# dec: 33 -> oct: 41
# dec: 34 -> oct: 42
# dec: 35 -> oct: 43
# dec: 36 -> oct: 44
# dec: 37 -> oct: 45
# dec: 38 -> oct: 46
# dec: 39 -> oct: 47
# dec: 40 -> oct: 50
# dec: 41 -> oct: 51
# dec: 42 -> oct: 52
# dec: 43 -> oct: 53
# dec: 44 -> oct: 54
# dec: 45 -> oct: 55
# dec: 46 -> oct: 56
# dec: 47 -> oct: 57
# dec: 48 -> oct: 60
# dec: 49 -> oct: 61
# dec: 50 -> oct: 62
