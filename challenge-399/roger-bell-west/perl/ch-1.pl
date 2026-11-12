#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Storable qw(dclone);
use List::Util qw(max);

sub lsub($wm, $t) {
  my $start = 0;
  my $state = 0;
  my @ll;
  foreach my $n (0 .. $#{$wm}) {
    if ($state == 0) {
      if ($wm->[$n] eq $t) {
        $start = $n;
        $state = 1;
      }
    } else {
      if ($wm->[$n] ne $t) {
        push @ll, $n - $start;
        $state = 0;
      }
    }
  }
  if ($state == 1) {
    push @ll, scalar @{$wm} - $start;
  }
  max(@ll);
}

sub longestrepeatingcharacter($st, $k) {
  my @origin = split '', $st;
  my %targets = map {$_ => 1} @origin;
  my $longestsub = 0;
  foreach my $t (keys %targets) {
    my @queue = ([\@origin, 0]);
    while (scalar @queue > 0) {
      my ($wm, $ct) = @{shift @queue};
      $longestsub = max($longestsub, lsub($wm, $t));
      if ($ct < $k) {
        my $ctp = $ct + 1;
        foreach my $n (0 .. $#{$wm}) {
          if ($wm->[$n] ne $t) {
            my $wmp = dclone($wm);
            $wmp->[$n] = $t;
            push @queue, [$wmp, $ctp];
          }
        }
      }
    }
  }
  $longestsub;
}

use Test::More tests => 5;

is(longestrepeatingcharacter('AAAAA', 2), 5, 'example 1');
is(longestrepeatingcharacter('ABCDE', 4), 5, 'example 2');
is(longestrepeatingcharacter('AAABBBBAA', 1), 5, 'example 3');
is(longestrepeatingcharacter('ABACADA', 2), 5, 'example 4');
is(longestrepeatingcharacter('BAAABAAAA', 1), 8, 'example 5');
