#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(nx([[qw(O O X)],[qw(X O O)],[qw(X O O)]]),1,"example 1");
is_deeply(nx([[qw(O O X O)],[qw(X O O O)],[qw(X O O X)],[qw(O X O O)]]),2,"example 2");

sub nx {
  my $n=shift;
  my $mr=$#{$n};
  my $mc=$#{$n->[0]};
  my $isol=0;
  foreach my $r (0..$mr) {
    foreach my $c (0..$mc) {
      unless ($n->[$r][$c] eq 'X') {
        next;
      }
      my $isolated=1;
      foreach my $dr (-1,0,1) {
        if ($r+$dr<0 || $r+$dr>$mr) {
          next;
        }
        foreach my $dc (-1,0,1) {
          if ($dc==0 && $dr==0) {
            next;
          }
          if ($c+$dc<0 || $c+$dc>$mc) {
            next;
          }
          if ($n->[$r+$dr][$c+$dc] eq 'X') {
            $isolated=0;
            last;
          }
        }
      }
      if ($isolated) {
        $isol++;
      }
    }
  }
  return $isol;
}
