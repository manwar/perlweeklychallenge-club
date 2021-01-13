#!/usr/bin/perl ;
use strict ;
use warnings ;
use List::Util qw ( max sum ) ;

my $A = $ARGV[ 0 ] ;
my $B = $ARGV[ 1 ] ;
my @factors ;
my $num = 1 ;
while ( $num < $A ) {
  push @factors , $num ;
  $num *= 2 ;
}
push @factors , $num ;
my @multfactors ;
while ( $A > 0 ) {
  my $subtrahend = max ( grep { $_ <= $A } @factors ) ;
  push @multfactors, $subtrahend ;
  $A -= $subtrahend ;
}
my $result = sum map { $_ * $B } @multfactors ;
print "$result\n" ;
