#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(atomscount('((N2O)3(H2O)2)2'), 'H8N12O10', 'example 1');
is(atomscount('Mg3(PO4)2'), 'Mg3O8P2', 'example 2');
is(atomscount('(((H)2)3)4'), 'H24', 'example 3');
is(atomscount('NaCl3(O2(S10)2)2Mg'), 'Cl3MgNaO4S40', 'example 4');
is(atomscount('Z2Y3(X2W)2'), 'W2X4Y3Z2', 'example 5');

sub atomscount($a) {
  my $i = 0;
  my @stack = ({});
  while ($i < length($a)) {
    my $as = substr($a, $i);
    if ($as =~ /^([A-Z][a-z]?)([0-9]+)/) {
      my $element = $1;
      my $ct = $2;
      $stack[-1]{$element} += $ct;
      $i += length($element) + length($ct);
    } elsif ($as =~ /^([A-Z][a-z]?)/) {
      my $element = $1;
      $stack[-1]{$element} += 1;
      $i += length($element);
    } elsif ($as =~ /^\(/) {
      push @stack, {};
      $i += 1;
    } elsif ($as =~ /^\)([0-9]+)/) {
      my $ct = $1;
      my $oc = pop @stack;
      while (my ($k, $v) = each %{$oc}) {
        $stack[-1]{$k} += $v * $ct;      }
      $i += length($ct) + 1;
    }
  }
  my $outstr;
  foreach my $k (sort keys %{$stack[0]}) {
    $outstr .= $k;
    if ($stack[0]{$k} > 1) {
      $outstr .= $stack[0]{$k};
    }
  }
  $outstr;
}
