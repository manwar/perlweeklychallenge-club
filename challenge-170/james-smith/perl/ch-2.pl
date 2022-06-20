#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $m1 = [ [1,2],[3,4] ];
my $m2 = [ [5,6],[7,8] ];

print Dumper( k_product( $m1, $m2 ) );
print Dumper( k( $m1, $m2 ) );
sub k_product {
  [ map { my$r = $_; map { my$t = $_; [ map { my$s=$_; map { $s*$_ } @{$t} } @{$r} ] } @{$_[1]} } @{$_[0]} ]
}
#----|----#----|----#----|----#----|----#----|----#----|----#----|----#--
#73 chars...
sub k{[map{$b=$_;map{$a=$_;[map{//;map{$'*$_}@$a}@$b]}@{$_[1]}}@{$_[0]}]}

