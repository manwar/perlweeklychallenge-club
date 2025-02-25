#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(deleteandearn([3, 4, 2]), 6, 'example 1');
is(deleteandearn([2, 2, 3, 3, 3, 4]), 9, 'example 2');

use List::Util qw(max);
use Storable qw(dclone);

sub deleteandearn($a) {
  my %ct;
  map {$ct{$_}++} @{$a};
  my $mx = 0;
  my @stack;
  push @stack, [\%ct, 0];
  while (scalar @stack > 0) {
    my $c = pop @stack;
    if (scalar %{$c->[0]} == 0) {
      $mx = max($mx, $c->[1]);
    } else {
      foreach my $d (keys %{$c->[0]}) {
        my $cc = dclone($c->[0]);
        $cc->{$d} -= 1;
        if ($cc->{$d} == 0) {
          delete $cc->{$d};
        }
        delete $cc->{$d - 1};
        delete $cc->{$d + 1};
        push @stack, [$cc, $c->[1] + $d];
      }
    }
  }
  $mx;
}
