#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a number string!" ;
my $A = <STDIN> ;
chomp $A ;
while ( $A !~ /\A\d+\z/ ) {
  say "the string should consist of digits only!" ;
  $A = <STDIN> ;
  chomp $A ;
}
say "Enter a second number string!" ;
my $B = <STDIN> ;
chomp $B ;
while ( $B !~ /\A\d+\z/ ) {
  say "the string should consist of digits only!" ;
  $B = <STDIN> ;
  chomp $B ;
}
while ( length $B != length $A || $B !~ /\A\d+\z/ ) {
  say ("second number string should be " . length( $A ) .
    " characters long!") ;
  say "digits only!" ;
  $B = <STDIN> ;
  chomp $B ;
}
my @fibonacciWords = ($A , $B) ;
while ( length($fibonacciWords[-1]) < 51 ) {
  push @fibonacciWords , $fibonacciWords[-2] . $fibonacciWords[-1] ;
}
say substr( $fibonacciWords[-1] , 50 , 1 ) ;
