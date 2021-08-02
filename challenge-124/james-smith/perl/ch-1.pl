#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use POSIX qw(ceil);
my $tau = 6.283185307179586476925286766559;


my $radius = @ARGV ? shift @ARGV : 10;
my $cross  = @ARGV ? shift @ARGV : $radius;
   $cross++ if $cross&1;

### A simple one to render the cross as drawin the question...

unless($radius) {
  my @pts = qw(-1 3 4 5 5 5 5 5 4 3 -1 0 0 0 -1 0 0);
  say $_ < 0 ? '    ^^^^^'
    : !$_    ? '      ^'
    : ' ' x (6-$_) . '^' . ' 'x($_*2-1) .'^'
    foreach @pts;
  exit;
}

## We will render the relevant sized venus symbol...

## Create the canvas..
my @a = map { ' ' x ($radius*2+1) } 0..$radius*2+$cross;

## Now we draw the circle...
foreach my $x (0 .. ceil($radius*0.71)) {
  my $y = int sqrt( ($radius-.5)**2 - $x**2 );
  substr $a[ $radius - $x ],$radius-$y,1,'^';
  substr $a[ $radius + $x ],$radius-$y,1,'^';
  substr $a[ $radius - $x ],$radius+$y,1,'^';
  substr $a[ $radius + $x ],$radius+$y,1,'^';
  substr $a[ $radius - $y ],$radius-$x,1,'^';
  substr $a[ $radius + $y ],$radius-$x,1,'^';
  substr $a[ $radius - $y ],$radius+$x,1,'^';
  substr $a[ $radius + $y ],$radius+$x,1,'^';
}

## And the two parts of the cross...
substr $a[2*$radius+$_],$radius,1,'^' foreach 0..$cross;
substr $a[2*$radius+$cross/2],$radius-$cross/2,$cross+1,'^'x($cross+1);

### Finally we render the canvas...
say $_ foreach @a;

