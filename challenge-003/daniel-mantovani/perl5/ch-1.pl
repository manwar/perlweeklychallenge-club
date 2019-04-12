#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

my $q = $ARGV[0];

die
  "Usage: perl $0 <n>\n\nwhere <n> is the (integer) quantity of hamming numbers you ask"
  unless $q && $q =~ /^\d+$/;

my @primes = (2, 3, 5);

# for each prime, we will define one vector (array), whith just one element [1]
# note that [1] will be first hamming code inside each array!

my %vec;
$vec{$_} = [1] for @primes;

for my $i (1 .. $q) {

# just look for the min value from the head of v2, v3 or v5
# (without using List::Util, as the challenge encourages no to use external modules)
  my $h;
  map { $h = $vec{$_}[0] unless $h && $h < $vec{$_}[0] } @primes;

  # and we just got the next hamming number!
  say "$i\t", $h;

  for my $f (@primes) {    # now for every prime factor
        # remove this value on each vector where it is present
    shift @{$vec{$f}} if $vec{$f}[0] == $h;

    # and finally calculate and insert new values to each vector
    # note that new pushed value is higer than any previous value in each vector
    push @{$vec{$f}}, $h * $f;
  }
}
