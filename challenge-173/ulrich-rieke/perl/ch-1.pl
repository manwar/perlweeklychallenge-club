#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

my $number = $ARGV[ 0 ] ;
my @digits = split( //, $number ) ;
my @pairs ;
for my $i ( 0 .. $#digits - 1 ) {
  push @pairs , [$digits[ $i ] , $digits[ $i + 1 ]] ;
}
if ( all { abs( $_->[0] - $_->[1] ) == 1 } @pairs ) {
  say "$number is esthetic!" ;
}
else {
  say "$number is not esthetic!" ;
}
