#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(balancestring('0a1b2c'), '0a1b2c', 'example 1');
is(balancestring('abc12'), 'a1b2c', 'example 2');
is(balancestring('0a1b2c3'), '0a1b2c3', 'example 3');
is(balancestring('1a23'), '', 'example 4');
is(balancestring('ab123'), '1a2b3', 'example 5');

sub balancestring($a) {
  my @letters;
  my @digits;
  foreach my $c (split '', $a) {
    if ($c =~ /[A-Z]/i) {
      push @letters, $c,
    } elsif ($c =~ /[0-9]/) {
      push @digits, $c;
    }
  }
  if (scalar @digits > scalar @letters + 1 ||
      scalar @letters > scalar @digits + 1) {
    return "";
  }
  @digits = sort @digits;
  @letters = sort @letters;
  my @a = @digits;
  my @b = @letters;
  if (scalar @letters == scalar @digits + 1) {
    @a = @letters;
    @b = @digits;
  }
  my @out;
  foreach my $i (0 .. scalar @b - 1) {
    push @out, $a[$i];
    push @out, $b[$i];
  }
  if (scalar @a > scalar @b) {
    push @out,$a[scalar @a - 1];
  }
  join('', @out);
}
