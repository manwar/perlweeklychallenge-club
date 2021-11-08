#! /usr/bin/perl

use strict;

use Test::More tests => 4;

is_deeply(csa([1,2,3,6,7,8,9]),[[1,2,3],[6,7,8,9]],'example 1');
is_deeply(csa([11,12,14,17,18,19]),[[11,12],[14],[17,18,19]],'example 2');
is_deeply(csa([2,4,6,8]),[[2],[4],[6],[8]],'example 3');
is_deeply(csa([1,2,3,4,5]),[[1,2,3,4,5]],'example 4');

sub csa {
  my ($list)=@_;
  my @o=([$list->[0]]);
  foreach my $ni (1..$#{$list}) {
    unless ($o[-1][-1]+1 == $list->[$ni]) {
      push @o,[];
    }
    push @{$o[-1]},$list->[$ni];
  }
  return \@o;
}
