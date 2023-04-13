#! /usr/bin/raku

use Test;

plan 4;

is-deeply(rearrangegroups([1, 2, 3, 5, 1, 2, 7, 6, 3], 3), [[1, 2, 3], [1, 2, 3], [5, 6, 7]], 'example 1');
is-deeply(rearrangegroups([1, 2, 3], 2), [], 'example 2');
is-deeply(rearrangegroups([1, 2, 4, 3, 5, 3], 3), [[1, 2, 3], [3, 4, 5]], 'example 3');
is-deeply(rearrangegroups([1, 5, 2, 6, 4, 7], 3), [], 'example 4');

sub rearrangegroups(@list, $size) {
  my %h;
  map {%h{$_}++},@list;
  my @out;
  while (True) {
    my $m = %h.keys.min;
    my @res = ($m + 0 .. $m + $size - 1);
    for @res -> $n {
      if (%h{$n}:exists) {
        %h{$n}--;
        if (%h{$n} == 0) {
          %h{$n}:delete;
        }
      } else {
        return [];
      }
    }
    @out.push(@res);
    unless (%h) {
      last;
    }
  }
  return @out;
}
