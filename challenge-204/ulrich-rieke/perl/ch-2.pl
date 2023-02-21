#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some rows of integers, separated by blanks!" ;
say "At the end, enter end!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers ;
while ( $line ne "end" ) {
  for my $n ( split( /\s/ , $line ) ) {
      push @numbers , $n ;
  }
  $line = <STDIN> ;
  chomp $line ;
}
say "Enter a row and a column number , separated by blanks!" ;
$line = <STDIN> ;
chomp $line ;
my ( $r , $c ) = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len % ( $r * $c ) != 0 ) {
  say 0 ;
}
else {
  if ( $r == 1 ) {
      say "(" . join( ',' , @numbers ) . ")" ;
  }
  else {
      for my $i (0..$r - 1 ) {
    print "(" . join( ',' , @numbers[$i * $c .. $i * $c + $c - 1] ) . ")" ;
      }
  }
  print "\n" ;
}
