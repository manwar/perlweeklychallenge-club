#!/usr/bin/perl

# Perl Weekly Challenge - 082
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-082/
#
# Task 2 - Interleave String
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

@ARGV = qw(4X 123X678 1234XX678)
  unless (scalar @ARGV >= 3);

my ($A, $B, $C) = @ARGV;

my $res = 'NONE';

if (length($A) + length($B) == length($C) and
    $C =~ m#^((?<A1>.*?)$B(?<A2>.*)|(?<B1>.*?)$A(?<B2>.*))$#) {
  if (($+{A1} // '').($+{A2} // '') eq $A) {
    $res = "$+{A1}|$B|$+{A2}";
  } elsif (($+{B1} // '').($+{B2} // '') eq $B) {
    $res = "$+{B1}|$A|$+{B2}";
  }
}

printf qq{
Input:
	\$A = "$A"
	\$B = "$B"
	\$C = "$C"

Output: %d

Interleaving: $res
}, $res ne 'NONE';

