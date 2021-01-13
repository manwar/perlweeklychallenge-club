#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

is_deeply(ii([[1,4],[8,10]],[2,6]),[[1,6],[8,10]],'example 1');
is_deeply(ii([[1,2],[3,7],[8,10]],[5,8]),[[1,2],[3,10]],'example 2');
is_deeply(ii([[1,5],[7,9]],[10,11]),[[1,5],[7,9],[10,11]],'example 3');
is_deeply(ii([[7,9],[10,11]],[1,5]),[[1,5],[7,9],[10,11]],'example 4');
is_deeply(ii([[1,5],[10,11]],[7,9]),[[1,5],[7,9],[10,11]],'example 5');

use List::Util qw(max);

sub ii {
  my ($iv,$nv)=@_;
  my @q=@{$iv};
  push @q,$nv;
  @q=sort {$a->[0] <=> $b->[0]} @q;
  my @out;
  foreach my $il (@q) {
    if (scalar @out == 0 ||
          $out[-1][1] < $il->[0]) {
      push @out,$il;
    } else {
      $out[-1][1]=max($out[-1][1],$il->[1]);
    }
  }
  return \@out;
}
