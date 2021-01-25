#!/usr/bin/perl

# Perl Weekly Challenge - 097
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/
#
# Task 1 - Caesar Cipher
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

# Unbuffered STDOUT
$|++;

my $N = shift(@ARGV) // 3;
my $S = uc(shift(@ARGV) // 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG');

die "N must be between 1 and 25"
  unless ($N >= 1 and $N <= 25);
die "S must be string with only 'A'..'Z' and spaces"
  unless ($S =~ m#^[ A-Z]+$#);

printf "Input: '%s'\n", $S;
printf "Output: '%s'\n", caesarCipher($S, $N);

sub caesarCipher {
  my ($s, $n) = @_;

  # Build 'cipher' hash (rotation encryption)
  my @cc = ('A' .. 'Z');
  my %cc = map {shift(@cc) => $_} (@cc[26-$N .. 25], @cc[0 .. 26-$N-1]);
  # Map space to space
  $cc{' '} = ' ';

  $s =~ s/(.)/$cc{$1}/g;

  return $s; 
}
