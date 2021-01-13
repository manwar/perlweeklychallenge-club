#!/usr/bin/perl

# Perl Weekly Challenge - 072
#
# Task 1 - Trailing Zeroes
#
# Author: Niels 'PerlBoy' van Dijke

use Math::BigInt;

my ($N) = @ARGV;

die "Argument must be positive number"
  unless (defined $N and $N =~ m#^[1-9][0-9]*$#);

my $tzNum = 0;
my $b = Math::BigInt->new($N)->bfac->as_int;
if ($b =~ m#([0]+)$#) {
  $tzNum = length($1);
}

print "Input: $N\n";
print "Output: $tzNum\n";
