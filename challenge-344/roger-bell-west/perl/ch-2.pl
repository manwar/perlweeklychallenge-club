#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(arrayformation([[2, 3], [1], [4]], [1, 2, 3, 4]), 1, 'example 1');
is(arrayformation([[1, 3], [2, 4]], [1, 2, 3, 4]), 0, 'example 2');
is(arrayformation([[9, 1], [5, 8], [2]], [5, 8, 2, 9, 1]), 1, 'example 3');
is(arrayformation([[1], [3]], [1, 2, 3]), 0, 'example 4');
is(arrayformation([[7, 4, 6]], [7, 4, 6]), 1, 'example 5');

use Storable qw(dclone);

sub arrayformation($src, $tgt) {
  my @stack;
  push @stack, [[], {map {$_ => 1} 0 .. $#{$src}}];
  while (scalar @stack > 0) {
    my $c = pop @stack;
    if ($#{$c->[0]} == $#{$tgt}) {
      return 1;
    } else {
      foreach my $candidate (keys %{$c->[1]}) {
        my $offset = scalar @{$c->[0]};
        my $nextcandidate = dclone($c->[1]);
        delete $nextcandidate->{$candidate};
        my $valid = 1;
        my $seq = dclone($c->[0]);
        values @{$src->[$candidate]};
        while (my ($i, $x) = each @{$src->[$candidate]}) {
          if ($x == $tgt->[$i + $offset]) {
            push @{$seq}, $x;
          } else {
            $valid = 0;
            last;
          }
        }
        if ($valid) {
          push @stack, [$seq, $nextcandidate];
        }
      }
    }
  }
  0;
}
