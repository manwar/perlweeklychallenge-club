#! /usr/bin/perl6

use Test;

plan 4;

is(lm(1,0,2,6),6210,'example 1');
is(lm(1,4,2,8),8412,'example 2');
is(lm(4,1,7,6),7614,'example 3');
is(lm(1,3,5,7),0,'example 4');

sub lm(**@n) {
  my @o=sort @n;
  my ($i,$t)=@o.first({$_ % 2 == 0}, :kv);
  unless (defined $i) {
    return 0;
  }
  splice @o,$i,1;
  @o=reverse @o;
  push @o,$t;
  return join('',@o);
}
