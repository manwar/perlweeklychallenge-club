#! /usr/bin/perl

use strict;
use warnings;

my %t;
while (<DATA>) {
  chomp;
  /^(.) (.*)$/;
  $t{$1}=$2;
}

my %e;
foreach my $char (keys %t) {
  $e{$char}=join('0',map {{'.' => '1',
                           '_' => '111'}->{$_}}
                     split '',$t{$char});
}

my $chars=join('',keys %t);

my @in;
while (<>) {
  chomp;
  my $t=uc($_);
  $t =~ s/[^ $chars]//g;
  push @in,$t;
}

my $m=join(' ',@in);

my @l;
foreach my $word (split ' ',$m) {
  my @w;
  foreach my $char (split '',$word) {
    push @w,$e{$char};
  }
  push @l,join('000',@w);
}
print join('0000000',@l),"\n";

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
