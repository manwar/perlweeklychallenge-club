#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter a number of integers, separated by blanks!( minimum of 3 )" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line) ;
my $len = scalar( @numbers ) ;
while ( $len < 3 ) {
  say "Enter at least 3 integers, separated by blanks!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers = split( /\s+/ , $line ) ;
  $len = scalar( @numbers ) ;
}
my $found = 0 ;
for my $i ( 1 .. $len - 2 ) {
  if ( sum ( @numbers[ 0 .. $i - 1] ) == sum ( @numbers[ $i + 1 .. $len - 1] )) {
      say $i ;
      $found = 1 ;
      last ;
  }
}
unless ($found) {
  say "-1 as no Equilibrium Index found." ;
}
