#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my $m1=[[1,2],[3,4]];
my $m2=[[5,6],[7,8]];

d($_) foreach $m1, $m2, k_product($m1,$m2), k($m1,$m2);

sub k_product {
  [ map { my$r = $_; map { my$t = $_; [ map { my$s=$_; map { $s*$_ } @{$t} } @{$r} ] } @{$_[1]} } @{$_[0]} ]
}
#----|----#----|----#----|----#----|----#----|----#----|----#----|----#--
#73 chars...
sub k{[map{$b=$_;map{$a=$_;[map{//;map{$'*$_}@$a}@$b]}@{$_[1]}}@{$_[0]}]}

#61 chars...
sub d{say"[ @{[map{sprintf'%6d',$_}@$_]} ]"for@{$_[0]};say''}

