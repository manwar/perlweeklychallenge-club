#!/usr/bin/perl

# Perl Weekly Challenge - 076
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/
#
# Task 1 - Prime Sum
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

# Sort of cheating... using some CPAN modules doing all the hard work
use Math::Prime::XS qw(primes);
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

my ($N) = @ARGV;

die "Input must be integer value and >= 2"
  unless (defined $N and $N =~ m#^[1-9][0-9]*$# and $N >= 2);

my @primes = primes($N);
my %primes = +map { $_ => 1 } @primes;

my @solution;

printf "%d Prime number candidates found to use for a solution\n", 
       scalar(@primes);

print "Searching for a solution (be patient... this can take a while...\n";

my $k = 1;

WHILE:
while ($k < scalar @primes) {
  printf "Using %d primes...\n", $k + 1;
  my $c = combinations(\@primes, $k);
  while (my $a = $c->next) {
    my $sum = sum(@$a);
    my $left = $N - $sum;
    if (exists $primes{$left} and !grep { $_ == $left } @$a) {
      @solution = (@$a, $N -$sum);
      last WHILE;
    }
  }
  $k++;
}

print "Input:\n";
printf "\t%s = %d\n\n", '$N', $N;

print "Output:\n";
if (scalar @solution) {
  printf "\t%d as the sum of prime numbers (%s) is same as input number.\n",
          scalar(@solution), join(', ', @solution);
} else {
  print "\tNo solution can be found.\n";
}

