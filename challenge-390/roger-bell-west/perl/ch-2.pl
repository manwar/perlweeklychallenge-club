#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(ordercharacters('dbca', 1), 'adbc', 'example 1');
is(ordercharacters('geeks', 2), 'eegks', 'example 2');
is(ordercharacters('cbaed', 3), 'abcde', 'example 3');
is(ordercharacters('fedcba', 4), 'abcdef', 'example 4');
is(ordercharacters('perl', 1), 'erlp', 'example 5');

sub ordercharacters($a, $k) {
  my @stack;
  push @stack, $a;
  my %seen;
  while (scalar @stack > 0) {
    my $s = pop @stack;
    foreach my $i (0 .. $k - 1) {
      my @sp = split '', $s;
      my $c = splice @sp, $i, 1;
      push @sp, $c;
      my $sn = join('', @sp);
      unless (exists $seen{$sn}) {
        $seen{$sn} = 1;
          push @stack, $sn;
      }
    }
  }
  (sort keys %seen)[0];
}
