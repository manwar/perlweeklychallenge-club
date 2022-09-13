#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

use List::Util qw(min);

is(commonpath([
  "/a/b/c/1/x.pl",
  "/a/b/c/d/e/2/x.pl",
  "/a/b/c/d/3/x.pl",
  "/a/b/c/4/x.pl",
  "/a/b/c/d/5/x.pl"
    ]), "/a/b/c", 'example 1');

sub commonpath($p) {
  my @pa;
  my @pl;
  foreach my $sp (@{$p}) {
    my @q = split '/',$sp;
    push @pl,scalar @q;
    push @pa,\@q;
  }
  my @out;
  foreach my $cl (0..min(@pl)-1) {
    my $ex = 0;
    my $tx = $pa[0][$cl];
    foreach my $pe (@pa) {
      if ($pe->[$cl] ne $tx) {
        $ex = 1;
        last;
      }
    }
    if ($ex) {
      last;
    }
    push @out,$tx;
  }
  return join('/',@out);
}
