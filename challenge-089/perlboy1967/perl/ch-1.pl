#!/usr/bin/perl

# Perl Weekly Challenge - 089
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-089/
#
# Task 1 - GCD Sum
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

use Scalar::Util qw(looks_like_number);
use POSIX qw(floor);
use Bit::Vector;

use Data::Printer;

my ($N) = @ARGV;

die "Please provide a integer number bigger than 2"
  unless (looks_like_number($N) and $N > 2 and $N == int($N));

my $bits = floor(log(2)/log($N));
my $vecGcd = Bit::Vector->new($bits);
my $vecA = Bit::Vector->new($bits);
my $vecB = Bit::Vector->new($bits);

my @G;
for my $i (1 .. $N - 1) {
  $vecA->from_Dec($i);
  for my $j ($i + 1 .. $N) {
    $vecB->from_Dec($j);
    $vecGcd->GCD($vecA, $vecB);
    push(@G, [$i,$j]) 
      if ($vecGcd->to_Dec() < $N);
  }
}

printf "Input: %d\n", $N;
printf "Output: %d\n\t%s\n", scalar(@G), join("\n\t", map {"gcd($_->[0],$_->[1])"} @G);
