#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [3,  1,2,3,5,1,2,7,6,3], '(1,2,3), (1,2,3), (5,6,7)' ],
  [ [2,  1,2,3            ], -1 ],
  [ [3,  1,2,4,3,5,3      ], '(1,2,3), (3,4,5)' ],
  [ [2,  1,2,4,3,5,3      ], -1 ],
  [ [3  ,1,5,2,6,4,7      ], -1 ],
);

sub rearrange_groups {
  my($s,%f,@res) = shift;
  return -1 if @_%$s;
  $s--;
  $f{$_}++ for @_;
  for my $k ( sort {$a<=>$b} keys %f ) {
    $f{$k} ? push @res, [$k,$f{$k}] : next;
    exists $f{$_} && $f{$_}>=$f{$k} ? ( $f{$_}-=$f{$k} ) : (return -1) for $k+1..$k+$s;
  }
  [map { ([$_->[0]..$_->[0]+$s]) x $_->[1] } @res]
}

sub d {
  ref $_[0] ? '('.join( '), (', map { join(',',@{$_}) } @{$_[0]} ).')' : $_[0];
}

is( d( rearrange_groups( @{$_->[0]} ) ), $_->[1] ) for @TESTS;
