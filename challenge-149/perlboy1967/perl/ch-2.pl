#!/bin/perl

=pod

The Weekly Challenge - 149
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-149/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Largest Square
Submitted by: Roger Bell_West

Given a number base, derive the largest perfect square with no repeated digits and return it as a string.
(For base>10, use ‘A’..‘Z’.)

=cut

use v5.16;

use bigint;
use List::MoreUtils qw(duplicates);
use POSIX qw(floor);

sub convertBase10toBaseN($$);
sub convertBaseNtoBase10($$);

my @digits = (0 .. 9, 'A' .. 'Z');

foreach my $base (2 .. 12) {
  my $iSqrt = sqrt convertBaseNtoBase10(join('', reverse @digits[0 .. $base-1]), $base);

  while ($iSqrt >= 1) {
    my $nSqr = convertBase10toBaseN($iSqrt * $iSqrt, $base);

    if (!duplicates(split//, $nSqr)) {
      say "f($base) = $nSqr";
      last;
    }

    $iSqrt--;
  }
}

sub convertBase10toBaseN ($$) {
  my ($n, $base) = @_;

  state $digits = [@digits];

  my @nMod; my %nMod;

  while ($n) {
    push(@nMod, $n % $base);
    $nMod{$nMod[-1]}++;
    $n = floor($n/$base);  # Use floor instead of int(..) for performance
  }

  return join('', reverse map {$digits->[$_]} @nMod);
}

sub convertBaseNtoBase10 ($$) {
  my ($n, $base) = @_;

  my ($res, $i) = (0, 0);
  state $digits = { map { ($_, $i++) } (@digits) };

  $i = 0;
  foreach (reverse split //, $n) {
    $res += $digits->{uc$_} * ($base**$i++);
  }

  return $res;
}
