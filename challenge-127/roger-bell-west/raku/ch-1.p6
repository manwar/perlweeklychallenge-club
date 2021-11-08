#! /usr/bin/perl6

use Test;

plan 2;

is(ds([1,2,5,3,4],[4,6,7,8,9]),0,'example 1');
is(ds([1,3,5,7,9],[0,2,4,6,8]),1,'example 2');

sub ds(@a,@b) {
  my $sa=set @a;
  my $sb=set @b;
  my $inter=$sa (&) $sb;
  if $inter.elems == 0 {
    return 1;
  } else {
    return 0;
  }
}
