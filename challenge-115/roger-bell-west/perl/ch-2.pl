#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(lm(1,0,2,6),6210,'example 1');
is(lm(1,4,2,8),8412,'example 2');
is(lm(4,1,7,6),7614,'example 3');
is(lm(1,3,5,7),0,'example 4');

use List::Util qw(first);

sub lm {
  my @o=sort @_;
  my $t=first {$_ % 2 == 0} @o;
  unless (defined $t) {
    return 0;
  }
  my $i=0;
  while (1) {
    if ($o[$i]==$t) {
      last;
    }
    $i++;
  }
  splice @o,$i,1;
  @o=reverse @o;
  push @o,$t;
  return join('',@o);
}
