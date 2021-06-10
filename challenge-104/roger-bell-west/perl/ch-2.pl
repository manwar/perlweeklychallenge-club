#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(game(),1,'example 1');
is(game(10),0,'example 2');
is(game(14),0,'example 3');

sub game {
  my $heap=shift || 12;
  my @players=qw(Alice Bob);
  my $a=0;
  while ($heap>0) {
    my $n=play($heap);
    $heap-=$n;
    warn "$players[$a] takes $n leaving $heap.\n";
    if ($heap==0) {
      warn "$players[$a] wins.\n";
      last;
    }
    $a++;
    $a %= 2;
  }
  return $a;
}

sub play {
  my $state=shift;
  my $m=$state % 4;
  if ($m==0) {
    return int(rand()*3)+1;
  } else {
    return $m;
  }
}
