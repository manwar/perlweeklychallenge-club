#!/usr/bin/perl

# Perl Weekly Challenge - 079
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#
# Task 1 - Count Set Bits
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use constant SOME_VALUE => 1000000007;

my ($N) = @ARGV;

die "N must be positive integer value"
  unless (defined $N and $N =~ m#^[1-9][0-9]*$#);

my $bits = countBits($N);

printf "Input: %d\n", $N;
printf "Output: %d %% %d = %d\n", 
       $bits, 
       SOME_VALUE(), 
       $bits % SOME_VALUE();

sub countBits {
  my ($n) = @_;

  my $b = 0;

  map {
    # Some 'unpack/pack' black magic
    $b += unpack('%32b*', pack('I', $_));
  } (1 .. $n);

  return $b;
}
