#!/usr/bin/perl

# Perl Weekly Challenge - 095
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/
#
# Task 1 - Palindrome Number
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

# Unbuffered STDOUT
$|++;

my $A = shift(@ARGV) // 1221;
my $B = reverse scalar $A;
my $C = ($A eq $B);

printf "Input: %d\n", $A;
printf "Output: %d%s\n",
       $C,($C ? '' : ", since $A and $B are not the same");
