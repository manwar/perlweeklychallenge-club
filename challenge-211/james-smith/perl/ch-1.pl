#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [[4,3,2,1],[5,4,3,2],[6,5,4,3]], 1 ],
  [ [[1,2,3],[3,2,1]],               0 ],
);

sub toeplitz {
  return if @_ > @{$_[0]}; ## unclear but no diagonals..
  my @st = @{$_[0]}[ 0 .. @{$_[0]} - @_ ];
  for my $r ( 1 .. $#_ ) {
    $st[$_] == $_[$r][$r+$_] || return 0 for 0 .. $#st;
  }
  1
}

is( toeplitz( @{$_->[0]} ), $_->[1] ) for @TESTS;
