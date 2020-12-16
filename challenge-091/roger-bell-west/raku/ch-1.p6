#! /usr/bin/perl6

use Test;

plan 3;

is(cn('1122234'),'21321314','example 1');
is(cn('2333445'),'12332415','example 2');
is(cn('12345'),'1112131415','example 3');

sub cn($n) {
  my @j=$n ~~ m:g/((.)$0*)/;
  my @out;
  for @j -> $match {
    my $q=$match.Str;
    @out.push(chars($q));
    @out.push(substr($q,0,1));
  }
  return @out.join('');
}
