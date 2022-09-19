#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use Time::HiRes qw(time);
use List::Util qw(sum);
use List::MoreUtils qw(zip6);

## This is the 20th and last Disarium number

my $TWENTIETH = 12_157_692_622_039_623_539;

## Generate first 19th Disarium numbers....

my($n,$t0)=(-1,time);

for(1..19) {
  my($c,$t) = (0,++$n);
  $t-= $_ ** ++ $c for split //,$n;
  $t ? (redo) : say sprintf ' %2d %24d %10.6f', $_, $n, time-$t0;
}

## We test the twentieth disarium number using our is_dis fn below

say sprintf ' %2d %24s %10.6f', 20, $TWENTIETH, time-$t0 if is_dis( $TWENTIETH );

say "> ",time-$t0;
$t0 = time;
## This is a "complex" map version...

$n = -1;
my @dis = map { while(1) { my($c,$t)=(0,++$n);
                           $t-=$_**++$c for split//,$n;
                           $t || last
                         }; $n } 1..19;
push @dis, $TWENTIETH;

say for @dis;
say "> ",time-$t0;
$t0=time;

$n=-1;
for(1..19) {
  my @t = split//,++$n;
  #say $n, ' ', sum map { $_->[0]**$_->[1] } zip6 @t, @{[1..@t]};
  redo if $n - sum map { $_->[0]**$_->[1] } zip6 @t, @{[1..@t]};
  say $n;
}
say "> ",time-$t0;

## First 19 are easy to find - there is a 20th - here we use a variant of the
## code above to check it...

sub is_dis {
  my($t,$c)=(pop,0);
  $t-=$_**++$c for split//,$t;
  $t?0:1
}

