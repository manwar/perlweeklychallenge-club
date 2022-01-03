#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ 3,5, '3/5 3/2 1/2 1/1' ],
  [ 4,3, '4/3 1/3 1/2 1/1' ],
  [ 101,45, '101/45 56/45 11/45 11/34 11/23 11/12 11/1 10/1 9/1 8/1 7/1 6/1 5/1 4/1 3/1 2/1 1/1' ],
);

is( stringify( tree($_->[0],$_->[1]) ), $_->[2] ) foreach @TESTS;

done_testing();

sub tree {
  my $tree = [[ my($n,$d)=@_ ]];
  push @{$tree}, [($n,$d)=$d>$n?($n,$d-$n):($n-$d,$d)] while $n>1||$d>1;
  $tree;
}

sub stringify {
  join q( ), map { "$_->[0]/$_->[1]" } @{$_[0]};
}

