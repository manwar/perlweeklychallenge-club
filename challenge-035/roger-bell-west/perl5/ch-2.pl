#! /usr/bin/perl

use strict;
use warnings;

my %t;
while (<DATA>) {
  chomp;
  /^(.) (.*)$/;
  $t{$1}=$2;
}

my %d;
foreach my $char (keys %t) {
  $d{join('0',map {{'.' => '1',
                    '_' => '111'}->{$_}}
              split '',$t{$char})}=$char;
}

my @in;
while (<>) {
  chomp;
  push @in,$_;
}

my $m=join('',@in);

my @m;
foreach my $word (split /0000000+/,$m) {
  my @w;
  foreach my $char (split /000+/,$word) {
    push @w,($d{$char} or '?');
  }
  push @m,join('',@w);
}
print join(' ',@m),"\n";

__DATA__
E .
I ..
S ...
H ....
5 .....
4 ...._
V ..._
3 ...__
U .._
F .._.
2 ..___
A ._
R ._.
L ._..
W .__
P .__.
J .___
1 .____
T _
N _.
D _..
B _...
6 _....
X _.._
K _._
C _._.
Y _.__
M __
G __.
Z __..
7 __...
Q __._
O ___
8 ___..
9 ____.
0 _____
