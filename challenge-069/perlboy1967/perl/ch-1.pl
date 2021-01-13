#!/usr/bin/perl

# Perl Weekly Challenge - 068
#
# Task 1 - Strobogrammatic Number
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

sub isStrobogrammaticNumber($);

my %stroboMap = (
  0 => 0,
  1 => 1,
  6 => 9,
  8 => 8,
  9 => 6,
);

my @l;

foreach my $i ($ARGV[0] .. $ARGV[1]) {
  push(@l, $i) if (isStrobogrammaticNumber($i));
}

printf "Output: %s\n", join(', ', @l);

sub isStrobogrammaticNumber($) {
  my ($i) = @_;

  return 0 if ($i =~ m#[23457]#);

  my ($left, $middle, $right);

  my $len = length($i);
  my $half = int($len / 2);

  my $re;
  if ($len == 1) {
    $re = '(?<middle>.)';
  } elsif ($len % 2 == 0) {
    $re = "^(?<left>.{$half})(?<right>.+)";
  } else {
    $re = "^(?<left>.{$half})(?<middle>.)(?<right>.+)";
  }
  if ($i =~ /$re/) {
    ($left, $middle, $right) = ($+{left}, $+{middle}, $+{right});
  }

  return 0 if (defined $middle and $middle ne $stroboMap{$middle});

  if (defined $left and defined $right) {
    my @l = split(//, $left);
    my @r = split(//, $right);

    foreach my $c (@l) {
      return 0 if ($c ne $stroboMap{pop(@r)});
    }
  }

  return 1;
}
