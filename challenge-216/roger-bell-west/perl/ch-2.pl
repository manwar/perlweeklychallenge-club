#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(wordstickers(['perl', 'raku', 'python'], 'peon'), 2, 'example 1');
is(wordstickers(['love', 'hate', 'angry'], 'goat'), 3, 'example 2');
is(wordstickers(['come', 'nation', 'delta'], 'accomodation'), 4, 'example 3');
is(wordstickers(['come', 'country', 'delta'], 'accomodation'), 0, 'example 4');

use Storable qw(dclone);

sub wordstickers($stickers, $word) {
  my %w;
  map {$w{$_}++} split '',lc($word);
  my $t = dclone(\%w);
  my @stick;
  foreach my $s (@{$stickers}) {
    my %f;
    map {$f{$_}++} split '',lc($s);
    map {delete $t->{$_}} keys %f;
    push @stick, \%f;
  }
  if (scalar %{$t}) {
    return 0;
  }
  my @stack = ([\%w, 0]);
  while (scalar @stack > 0) {
    my $st = shift @stack;
    if (scalar %{$st->[0]} == 0) {
      return $st->[1];
    } else {
      my $n = $st->[1] + 1;
      foreach my $sti (@stick) {
        my $sp = dclone($st->[0]);
        my $v = 0;
        foreach my $l (keys %{$sti}) {
          if (exists $sp->{$l}) {
            $v = 1;
            my $p = $sp->{$l} - $sti->{$l};
            if ($p > 0) {
              $sp->{$l} = $p;
            } else {
              delete $sp->{$l};
            }
          }
        }
        if ($v) {
          push @stack, [$sp, $n];
        }
      }
    }
  }
}
