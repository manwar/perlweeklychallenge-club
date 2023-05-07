#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
 [ ['abc', 'xyz', 'tsu'], 1 ],
 [ ['rat', 'cab', 'dad'], 3 ],
 [ ['baa', 'ill', 'zzy', 'abc' ], 2 ],
 [ ['x', 'y', 'z'],       0 ]
);

sub non_alpha {
  return 0 if length $_[0] <2;
  my($c,$f)=0;
  for(@_) {
    $f='';
    $f gt $_ ? ($c++,last) : ($f=$_) for split //;
  }
  $c
}

sub non_alpha_compact {
  return 0 if length $_[0] <2;
  my($c,$f)=0;
  $f='', map { $f gt $_ ? ($c++,next) : ($f=$_) } split // for @_;
  $c
}


is( non_alpha( @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();
