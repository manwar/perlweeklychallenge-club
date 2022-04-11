#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is(fim(5),"Five is four, four is magic.",'example 1');
is(fim(7),"Seven is five, five is four, four is magic.",'example 2');
is(fim(6),"Six is three, three is five, five is four, four is magic.",'example 3');
is(fim(4),"Four is magic.",'example 4');

sub fim {
  my $n=shift;
  my @words=qw(zero one two three four five six seven eight nine);
  my @p;
  while (1) {
    my $s=$words[$n] . ' is ';
    if ($n == 4) {
      $s .= 'magic.';
      push @p,$s;
      last;
    } else {
      $n=length($words[$n]);
      $s .= $words[$n];
      push @p,$s;
    }
  }
  return ucfirst(join(', ',@p));
}
