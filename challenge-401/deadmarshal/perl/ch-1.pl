#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub gcd{
  my ($a,$b) = map{abs} @_;
  ($a,$b) = ($b,$a % $b) while $b;
  $a
}

sub fraction_addition_subtraction{
  my ($expr) = @_;
  my ($num,$den) = (0,1);
  while($expr =~ m{([+-]?\d+)/(\d+)}g){
    my ($n,$d) = ($1,$2);
    $num = $num * $d + $n * $den;
    $den *= $d;
    my $g = gcd($num,$den);
    ($num,$den) = ($num / $g,$den / $g) if $g > 1
  }
  "$num/$den"
}

is fraction_addition_subtraction('1/2+3/2'),'2/1','Example 1';
is fraction_addition_subtraction('-5/2-3/2'),'-4/1','Example 2';
is fraction_addition_subtraction('5/3-5/3'),'0/1','Example 3';
is fraction_addition_subtraction('10/10-1/10+2/5'),'13/10','Example 4';
is fraction_addition_subtraction('1/6+1/6+1/6'),'1/2','Example 5';

