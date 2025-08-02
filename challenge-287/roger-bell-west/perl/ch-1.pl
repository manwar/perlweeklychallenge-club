#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(strongpassword('a'), 5, 'example 1');
is(strongpassword('aB2'), 3, 'example 2');
is(strongpassword('PaaSW0rd'), 0, 'example 3');
is(strongpassword('Paaasw0rd'), 1, 'example 4');
is(strongpassword('aaaaa'), 3, 'example 5');

use List::Util qw(sum max);

sub strongpassword($a) {
  my %ctypes;
  my $reps = 0;
  my $rep = 0;
  my $old = '@';
  my @changes;
  my @chars = split '',$a;
  while (my ($i, $c) = each @chars) {
    if ($i > 0 && $c eq $old) {
      $rep += 1;
      if ($rep >= 2) {
        $reps += 1;
      }
    } else {
      $rep = 0;
      $old = $c;
    }
    my $t = 'n';
    if ($c =~ /[[:upper:]]/) {
      $t = 'u';
    } elsif ($c =~ /[[:lower:]]/) {
      $t = 'l';
    } elsif ($c =~ /[[:digit:]]/) {
      $t = 'd';
    }
    $ctypes{$t}++;
  }
  push @changes, $reps;
  delete $ctypes{n};
  my $k = scalar keys %ctypes;
  if ($k < 3) {
    my $spare = sum(values %ctypes) - $k;
    if ($spare < 0) {
      push @changes, -$spare;
    }
  }
  if (length($a) < 6) {
    push @changes, 6 - length($a);
  }
  return max(@changes);
}
