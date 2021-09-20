#! /usr/bin/perl6

use Test;

plan 4;

is-deeply(csa([1,2,3,6,7,8,9]),[[1,2,3],[6,7,8,9]],'example 1');
is-deeply(csa([11,12,14,17,18,19]),[[11,12],[14],[17,18,19]],'example 2');
is-deeply(csa([2,4,6,8]),[[2],[4],[6],[8]],'example 3');
is-deeply(csa([1,2,3,4,5]),[[1,2,3,4,5],],'example 4');

sub csa(@list) {
  my @o=(Array.new(@list[0]),);
  for 1..@list.end -> $ni {
    unless (@o[*-1][*-1]+1 == @list[$ni]) {
      push @o,Array.new;
    }
    push @(@o[*-1]),@list[$ni];
  }
  return @o;
}
