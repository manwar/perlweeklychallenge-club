#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(spn([5,2,-2,0]),1,'example 1');
is(spn([1,8,-1]),2,'example 2');
is(spn([2,0,-1]),1,'example 3');

sub spn {
  my @list=@{shift @_};
  my %r=map {$_ => 1} grep {$_ > 0} @list;
  my $m=1;
  while (exists $r{$m}) {
    $m++;
  }
  return $m;
}
