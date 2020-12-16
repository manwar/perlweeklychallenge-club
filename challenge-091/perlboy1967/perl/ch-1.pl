#!/usr/bin/perl

# Perl Weekly Challenge - 091
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-091/
#
# Task 1 - Count Number
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

use Scalar::Util qw(looks_like_number);

my ($N) = @ARGV;
my $M;

die "Please provide a positive integer number"
  unless (looks_like_number($N) and $N > 0 and $N == int($N));

while ($N =~ m#((\d)\2*)#g) {
  $M .= sprintf('%d%s', length($1), $2);
}

printf "Input: %d\n", $N;
printf "Output: %d\n", $M;
