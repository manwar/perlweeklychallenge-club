#! /usr/bin/perl6

use Test;

plan 5;

is-deeply(ii([[1,4],[8,10]],[2,6]),[[1,6],[8,10]],'example 1');
is-deeply(ii([[1,2],[3,7],[8,10]],[5,8]),[[1,2],[3,10]],'example 2');
is-deeply(ii([[1,5],[7,9]],[10,11]),[[1,5],[7,9],[10,11]],'example 3');
is-deeply(ii([[7,9],[10,11]],[1,5]),[[1,5],[7,9],[10,11]],'example 4');
is-deeply(ii([[1,5],[10,11]],[7,9]),[[1,5],[7,9],[10,11]],'example 5');

sub ii($iv,$nv) {
  my @q=$iv.flat;
  push @q,$nv;
  @q=sort {$^a[0] <=> $^b[0]}, @q;
  my @out;
  for @q -> $il {
    if (@out.elems == 0 ||
          @out[@out.end][1] < $il[0]) {
      push @out,$il;
    } else {
      @out[@out.end][1]=max(@out[@out.end][1],$il[1]);
    }
  }
  return @out;
}
