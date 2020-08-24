#! /usr/bin/perl6

use Test;

plan 2;

is(majority((1, 2, 2, 3, 2, 4, 2)),
   2,
   "example 1");
is(majority((1, 3, 1, 2, 4, 5)),
   -1,
   "example 2");

sub majority(@list) {
  my %s;
  map {%s{$_}++}, @list;
  my $m=max(values %s);
  if ($m > floor(@list.elems/2)) {
    my %q=map {%s{$_} => $_},keys %s;
    return %q{$m};
  } else {
    return -1;
  }
}
