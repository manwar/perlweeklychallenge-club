#!/bin/perl

=pod

The Weekly Challenge - 183
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-183/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Unique Array
Submitted by: Mohammad S Anwar

You are given list of arrayrefs.

Write a script to remove the duplicate arrayrefs from the given list.

=cut

use v5.16;
use warnings;

use Test::More;
use Test::Deep qw(cmp_deeply);

use Data::Compare;

####################################################################
# sub uuniq(@list)
#
# Description: Returns a unique list regardlessly list element types
# Name: Universal uniq => 'uuniq'
####################################################################
sub uuniq (@) {
  my @r;
  map {
    my $r = $_;
    push(@r,$_)
      if (!grep { Data::Compare::Compare($r,$_) } @r);
  } @_;
  return @r;
}

# Simple 'uniq'
cmp_deeply([uuniq(1,2,3,4,5,4,3,2,1)],
           [1,2,3,4,5]);
# Uniq list of lists
cmp_deeply([uuniq([1,2],[3,4],[5,6],[1,2])],
           [[1,2],[3,4],[5,6]]);
cmp_deeply([uuniq([9,1],[3,7],[2,5],[2,5])],
           [[9,1],[3,7],[2,5]]);
cmp_deeply([uuniq([1,2],[1,2,3],[1,2],[2,3])],
           [[1,2],[1,2,3],[2,3]]);
# Uniq list of hashes
cmp_deeply([uuniq({a=>1},{b=>2},{a=>1})],
           [{a=>1},{b=>2}]);
cmp_deeply([uuniq({a=>1},{a=>1,b=>2},{b=>2},{a=>1})],
           [{a=>1},{a=>1,b=>2},{b=>2}]);
# Going wild.... :-)
cmp_deeply([uuniq(1,[1,2],2,[2,3],2,{a=>1},{b=>1},{a=>1},[1,2])],
           [1,[1,2],2,[2,3],{a=>1},{b=>1}]);

done_testing();
