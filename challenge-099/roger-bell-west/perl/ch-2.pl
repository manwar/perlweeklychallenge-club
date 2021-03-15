#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(us('littleit','lit'),5,'example 1');
is(us('london','lon'),3,'example 2');

use List::Util qw(sum);

sub us {
  my $text=shift;
  my $match=shift;
  my %s;
  {
    my $i=0;
    foreach my $c (split '',$text) {
      push @{$s{$c}},$i;
      $i++;
    }
  }
  my @j;
  foreach my $c (split '',$match) {
    if (exists $s{$c}) {
      push @j,$s{$c};
    } else {
      return 0;
    }
  }
  my @o=(1) x scalar @{$j[0]};
  foreach my $m (1..$#j) {
    my @n;
    foreach my $bi (0..$#{$j[$m]}) {
      my $t=0;
      foreach my $ai (0..$#{$j[$m-1]}) {
        if ($j[$m-1][$ai] < $j[$m][$bi]) {
          $t+=$o[$ai];
        }
      }
      push @n,$t;
    }
    @o=@n;
  }
  return sum(@o);
}
